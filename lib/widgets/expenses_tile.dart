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
    if(expmodel.expenseID.substring(0,10) == "GSExpenses")
      {
        return GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => ExpenseDetail(expmodel: expmodel)));
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
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            child: Image.asset('assets/Images/cash.png')
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(expmodel.title, style: const TextStyle(color: Colors.black, fontSize: 15),),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    double tbalance = 0;
    Widget a;
    if (expmodel.paidBy == UserStore.uid)
    {
      tbalance = expmodel.amount - expmodel.owe[UserStore.uid]!;
      a = Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text('You Lent', style: TextStyle(color: Colors.green, fontSize: 10),),
          Text('\u{20B9}${tbalance.toStringAsFixed(2)}', style: const TextStyle(color: Colors.green, fontSize: 15),),
        ],
      );
    }
    else
      {
        print("HHEEE");
        print(expmodel.owe);
        print(UserStore.uid);
        if(expmodel.owe[UserStore.uid] == null)
          {
            a = Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('Not involved', style: TextStyle(color: Colors.black87, fontSize: 10),),
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
                Text('\u{20B9}${tbalance.toStringAsFixed(2)}', style: const TextStyle(color: Colors.orange, fontSize: 15),),
              ],
            );
          }

      }
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ExpenseDetail(expmodel: expmodel)));
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
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        child:
                        expmodel.type == 'Food' ? Image.asset('assets/Images/food.png') :
                        expmodel.type == 'Shopping' ? Image.asset('assets/Images/shopping.png') :
                        expmodel.type == 'Travel' ? Image.asset('assets/Images/car.png') :
                        expmodel.type == 'Movies' ? Image.asset('assets/Images/cinema.png') :
                        expmodel.type == 'settle' ? Image.asset('assets/Images/cash.png') :
                        Image.asset('assets/Images/others.png')


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
                  Text('${expmodel.paidBy == UserStore.uid?"You":UIDN(expmodel.paidBy)} Paid \u{20B9}${expmodel.amount.toStringAsFixed(2)}', style: const TextStyle(color: Colors.black, fontSize: 13),),
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
