import 'package:flutter/material.dart';
import 'package:splitwise/firebase/firestore.dart';
import 'package:splitwise/stores/user_store.dart';

import '../../functions/email_to_uid.dart';
import '../../widgets/expenses_tile.dart';

class FriendDetail extends StatefulWidget {
  final String keyo;
  const FriendDetail({Key? key, required this.keyo}) : super(key: key);

  @override
  State<FriendDetail> createState() => _FriendDetailState();
}

class _FriendDetailState extends State<FriendDetail> {
  @override
  Widget build(BuildContext context) {
    double bal = UserStore.friends[widget.keyo]!.owe;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      UIDN(widget.keyo),
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      bal == 0
                          ? 'You and ${UIDN(widget.keyo)} are settled up'
                          : bal > 0
                              ? '${(UIDN(widget.keyo))} owes you \u{20B9}$bal overall'
                              : 'You owe ${(UIDN(widget.keyo))} \u{20B9}$bal overall',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: FireStrMtd().getFriendExpenses(widget.keyo),
              builder: (context, snapshot) {
              if(!snapshot.hasData)
                {
                  return CircularProgressIndicator();
                }
              return Column(
                children: [
                  for (var expmodel in snapshot.data!)
                    ExpenseTile(
                      expmodel: expmodel,
                    )
                ],
              );
          }),
        ],
      ),
    );
  }
}
