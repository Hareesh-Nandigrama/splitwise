import 'package:flutter/material.dart';
import 'package:splitwise/models/expense_model.dart';
import 'package:intl/intl.dart';
import 'package:splitwise/screens/expenses/expense_detail.dart';
import 'package:splitwise/stores/user_store.dart';

import '../functions/email_to_uid.dart';

class ExpenseTile extends StatelessWidget {
  final ExpenseModel expmodel;
  const ExpenseTile({Key? key, required this.expmodel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double tbalance = 0;
    Widget a;
    if (expmodel.paidBy == UserStore.uid)
    {
      tbalance = expmodel.amount - expmodel.owe[UserStore.uid]!;
      a = Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text('You Lent', style: TextStyle(color: Colors.green, fontSize: 10),),
          Text(tbalance.toString(), style: const TextStyle(color: Colors.green, fontSize: 15),),
        ],
      );
    }
    else
      {
        tbalance = expmodel.owe[UserStore.uid]!;
        a = Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text('You Took', style: TextStyle(color: Colors.orange, fontSize: 10),),
            Text(tbalance.toString(), style: const TextStyle(color: Colors.orange, fontSize: 15),),
          ],
        );
      }
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ExpenseDetail(expModel: expmodel)));
      },
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Text(DateFormat('MMM').format(expmodel.date)),
                  Text(expmodel.date.day.toString()),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        child: Image.network("https://cdn-icons-png.flaticon.com/512/570/570170.png"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(expmodel.title, style: const TextStyle(color: Colors.black, fontSize: 20),),
                  Text('${UIDN(expmodel.paidBy)} Paid ${expmodel.amount}', style: const TextStyle(color: Colors.black, fontSize: 13),),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: a
            ),
          ),

        ],
      ),
    );
  }
}
