import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/firebase/firestore.dart';
import 'package:splitwise/screens/friends/friend_settle.dart';
import 'package:splitwise/stores/user_store.dart';

import '../../functions/email_to_uid.dart';
import '../../stores/common_store.dart';
import '../../widgets/expenses_tile.dart';
import '../groups/settle/settle_up_page.dart';

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
    var commonStore = context.read<CommonStore>();

    return SafeArea(
      child: Observer(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Column(
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
                                      ? '${(UIDN(widget.keyo))} owes you \u{20B9}${bal.abs()} overall'
                                      : 'You owe ${(UIDN(widget.keyo))} \u{20B9}${bal.abs()} overall',
                              style: TextStyle(fontSize: 20,
                              color: bal > 0 ? Colors.green : bal < 0 ? Colors.orange : Colors.black),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  // bal < 0 ? Row(
                  //   children: [
                  //     SizedBox(
                  //       width: 40,
                  //     ),
                  //     Expanded(
                  //       child: Padding(
                  //         padding: const EdgeInsets.all(8.0),
                  //         child: ElevatedButton(
                  //           onPressed: () {
                  //             //Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettleConfirmPage2(from: UserStore.uid, to: widget.keyo, groupId: 'l', amount: bal, )));
                  //           },
                  //           style: ElevatedButton.styleFrom(
                  //               padding: const EdgeInsets.all(10),
                  //               backgroundColor: Colors.orange),
                  //           child: const Text('Settle up'),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 40,
                  //     ),
                  //   ],
                  // ) : Container(),
                  FutureBuilder(
                    future: FireStrMtd().getFriendExpenses(widget.keyo),
                      builder: (context, snapshot) {
                      if(!snapshot.hasData)
                        {
                          return CircularProgressIndicator();
                        }
                      return Column(
                        children: [
                          for (var expmodel in snapshot.data!.reversed)
                            ExpenseTile(
                              expmodel: expmodel,
                            )
                        ],
                      );
                  }),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
