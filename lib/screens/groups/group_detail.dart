import 'package:flutter/material.dart';
import 'package:splitwise/firebase/firestore.dart';
import 'package:splitwise/widgets/fields/expenses_tile.dart';

import '../../models/user_groups_model.dart';
import '../expenses/add_expense.dart';

class GroupDetails extends StatefulWidget {
  final UserGroupModel userGrpModel;
  const GroupDetails({Key? key, required this.userGrpModel, }) : super(key: key);

  @override
  State<GroupDetails> createState() => _GroupDetailsState();
}

class _GroupDetailsState extends State<GroupDetails> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FireStrMtd().getGroupDetails(widget.userGrpModel.groupID),
      builder: (context,snapshot) {
        double tbalance = widget.userGrpModel.owe;
        if (!snapshot.hasData) {
          return Scaffold(
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
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        }
        return Scaffold(
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
                        for (var expmodel in snapshot.data!.expenses)
                          ExpenseTile(
                            expmodel: expmodel,
                          )
                      ],
                    ),
                  ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddExpensePage( grpModel: snapshot.data!,)));
                },
                child: const Text('Add Expenses')));
      }
    );
  }
}
