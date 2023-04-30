import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/firebase/firestore.dart';
import 'package:splitwise/screens/groups/settle/settle_up_page.dart';
import 'package:splitwise/widgets/expenses_tile.dart';

import '../../models/user_groups_model.dart';
import '../../stores/common_store.dart';
import '../expenses/add_expense.dart';
import 'balances_page.dart';

class GroupDetails extends StatefulWidget {
  final UserGroupModel userGrpModel;
  const GroupDetails({Key? key, required this.userGrpModel, }) : super(key: key);

  @override
  State<GroupDetails> createState() => _GroupDetailsState();
}

class _GroupDetailsState extends State<GroupDetails> {
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    return Observer(
      builder: (context) {
        print(commonStore.counter);
        return FutureBuilder(
          future: FireStrMtd().getGroupDetails(widget.userGrpModel.groupID),
          builder: (context,snapshot) {
            double tbalance = widget.userGrpModel.owe;
            if (!snapshot.hasData) {
              return SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: const Icon(Icons.chevron_left_sharp),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    title: Text(widget.userGrpModel.title),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        tbalance > 0
                            ? Text(
                          'You are owed ${tbalance.toStringAsFixed(2)} overall',
                          style: const TextStyle(color: Colors.green, fontSize: 20),
                        )
                            : tbalance == 0
                            ? const Text(
                          'settled up',
                          style:
                          TextStyle(color: Colors.grey, fontSize: 20),
                        )
                            : Text(
                          'You owe ${(-1 * tbalance).toStringAsFixed(2)} overall',
                          style: const TextStyle(
                              color: Colors.orange, fontSize: 20),
                        ),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ),
              );
            }
            return SafeArea(
              child: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      icon: const Icon(Icons.chevron_left_sharp),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    title: Text(widget.userGrpModel.title),
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                tbalance > 0
                                    ? Text(
                                        'You are owed \u{20B9}${tbalance.toStringAsFixed(2)} overall',
                                        style: const TextStyle(color: Colors.green, fontSize: 20),
                                      )
                                    : tbalance == 0
                                        ? const Text(
                                            'settled up',
                                            style:
                                                TextStyle(color: Colors.grey, fontSize: 20),
                                          )
                                        : Text(
                                            'You owe \u{20B9}${(-1 * tbalance).toStringAsFixed(2)} overall',
                                            style: const TextStyle(
                                                color: Colors.orange, fontSize: 20),
                                          ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettleUpPage(model: snapshot.data!)));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.all(10),
                                            backgroundColor: Colors.orange),
                                        child: const Text('Settle up'),
                                      ),
                                    ),
                                    SizedBox(
                                      child: Container(),
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => BalancesPage(model: snapshot.data!)));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.all(10),
                                            backgroundColor: Colors.orange),
                                        child: const Text('Balances'),
                                      ),
                                    ),
                                  ],
                                ),
                                for (var expmodel in snapshot.data!.expenses)
                                  ExpenseTile(
                                    expmodel: expmodel,
                                  )
                              ],
                            ),
                          ),
                  ),
                  floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddExpensePage( grpModel: snapshot.data!,)));
                      },
                      child: const Text('Add Expenses'))),
            );
          }
        );
      }
    );
  }
}
