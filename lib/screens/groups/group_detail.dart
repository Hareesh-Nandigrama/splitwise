import 'package:flutter/material.dart';
import 'package:splitwise/firebase/firestore.dart';
import 'package:splitwise/models/group_model.dart';
import 'package:splitwise/stores/user_store.dart';
import 'package:splitwise/widgets/fields/expenses_tile.dart';

import '../expenses/add_expense.dart';

class GroupDetails extends StatefulWidget {
  final GroupModel grpModel;
  const GroupDetails({Key? key, required this.grpModel}) : super(key: key);

  @override
  State<GroupDetails> createState() => _GroupDetailsState();
}

class _GroupDetailsState extends State<GroupDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left_sharp),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(widget.grpModel.title),
        ),
        body: FutureBuilder(
            future: FireStrMtd().getGroupExpenses(widget.grpModel),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              Map<String, double> balances = {};
              balances[UserStore.email] = 0;
              for (String person in widget.grpModel.people) {
                print(person);
                balances[person] = 0;
              }
              for (var expmodel in snapshot.data!.values) {
                if (expmodel.paidBy == UserStore.email) {
                  for (String key in expmodel.owe.keys) {
                    balances[key] = expmodel.owe[key]! + balances[key]!;
                  }
                } else {
                  if (expmodel.owe.keys.contains(UserStore.email)) {
                    balances[expmodel.paidBy] = -1 *
                        (expmodel.owe[UserStore.email]! -
                            balances[expmodel.paidBy]!);
                  }
                }
              }

              balances.remove(UserStore.email);

              double tbalance = 0;
              for (var x in balances.values) {
                tbalance += x;
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    tbalance > 0
                        ? Text(
                            'You are owed $tbalance overall',
                            style: const TextStyle(color: Colors.green, fontSize: 20),
                          )
                        : tbalance == 0
                            ? const Text(
                                'settled up',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 20),
                              )
                            : Text(
                                'You owe ${-1 * tbalance} overall',
                                style: const TextStyle(
                                    color: Colors.orange, fontSize: 20),
                              ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(320, 0),
                          padding: const EdgeInsets.all(10),
                          backgroundColor: Colors.orange),
                      child: const Text('Settle up'),
                    ),
                    for (var expmodel in snapshot.data!.values)
                      ExpenseTile(
                        expmodel: expmodel,
                      )
                  ],
                ),
              );
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddExpensePage( grpModel:widget.grpModel,)));
            },
            child: const Text('Add Expenses')));
  }
}
