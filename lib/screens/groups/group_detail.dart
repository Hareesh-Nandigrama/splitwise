import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/firebase/firestore.dart';
import 'package:splitwise/models/expense_model.dart';
import 'package:splitwise/screens/groups/settle/settle_up_page.dart';
import 'package:splitwise/widgets/expenses_tile.dart';

import '../../functions/activity_filter_function.dart';
import '../../models/user_groups_model.dart';
import '../../stores/common_store.dart';
import '../../widgets/fields/filter.dart';
import '../expenses/add_expense.dart';
import 'balances_page.dart';
import 'group_settings_page.dart';

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
                        const CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Observer(
              builder: (context) {
                List<ExpenseModel> lt = filterFunction(input: snapshot.data!.expenses, type: commonStore.type, type2: commonStore.type2);

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
                        actions: [
                          snapshot.data!.creator != 'ADMIN__ADMIN' ? IconButton(onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => GroupSettingsPage(model: snapshot.data!)));
                          }, icon: Icon(Icons.settings)) : Container()
                        ],
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
                                    Row(
                                        children: const [

                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                  height: 100,
                                                  width: 150,
                                                  child: Center(child: FilterBar(
                                                    items: ['All','You Owe','You are owed'], hintText: 'Balance Type'
                                                    , index: 1,

                                                  ))),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                  height: 100,
                                                  width: 150,
                                                  child: Center(child: FilterBar(
                                                    items: ['All','Food','Shopping','Travel','Movies','Others','settle'], hintText: 'Expense Type'
                                                    ,index: 0,

                                                  ))),
                                            ),
                                          ),

                                        ]),
                                    for (var expmodel in lt.reversed)
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
    );
  }
}
