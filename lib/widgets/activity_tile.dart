import 'package:flutter/material.dart';
import 'package:splitwise/models/expense_model.dart';
import 'package:splitwise/screens/expenses/expense_detail.dart';
import 'package:splitwise/stores/user_store.dart';
import 'package:intl/intl.dart';
import '../functions/email_to_uid.dart';

class ActivityTile extends StatelessWidget {
  final ExpenseModel expmodel;
  const ActivityTile({Key? key, required this.expmodel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (expmodel.expenseID.substring(0, 5) == 'Group') {
      return ListTile(
        leading: SizedBox(
          height: 50,
          width: 50,
          child: expmodel.type == 'Food' ? Image.asset('assets/Images/food.png') :
          expmodel.type == 'Shopping' ? Image.asset('assets/Images/shopping.png') :
          expmodel.type == 'Travel' ? Image.asset('assets/Images/car.png') :
          expmodel.type == 'Movies' ? Image.asset('assets/Images/cinema.png') :
          expmodel.type == 'settle' ? Image.asset('assets/Images/cash.png') :

          Image.asset('assets/Images/others.png')
        ),
        title: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 20),
            children: <TextSpan>[
              TextSpan(
                  text: expmodel.paidBy == UserStore.uid
                      ? 'You'
                      : UIDN(expmodel.paidBy),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: ' created group '),
              TextSpan(
                  text: '"' + expmodel.title + '"',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text:
                        DateFormat('dd MMM, hh:mm aaa').format(expmodel.date),
                        style: TextStyle(color: Colors.black87,fontSize: 10)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    else if(expmodel.expenseID.substring(0,10) == 'GSExpenses')
      {
        return ListTile(
          leading: SizedBox(
              height: 50,
              width: 50,
              child: expmodel.type == 'Food' ? Image.asset('assets/Images/food.png') :
              expmodel.type == 'Shopping' ? Image.asset('assets/Images/shopping.png') :
              expmodel.type == 'Travel' ? Image.asset('assets/Images/car.png') :
              expmodel.type == 'Movies' ? Image.asset('assets/Images/cinema.png') :
              expmodel.type == 'settle' ? Image.asset('assets/Images/cash.png') :
              Image.asset('assets/Images/others.png')
          ),
          title: RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 20),
              children: <TextSpan>[
                TextSpan(text:  expmodel.title),

              ],
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                          text:
                          DateFormat('dd MMM, hh:mm aaa').format(expmodel.date),
                          style: TextStyle(color: Colors.black87,fontSize: 10)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ExpenseDetail(expmodel: expmodel)));
      },
      child: ListTile(
        leading: SizedBox(
            height: 50,
            width: 50,
            child: expmodel.type == 'Food' ? Image.asset('assets/Images/food.png') :
            expmodel.type == 'Shopping' ? Image.asset('assets/Images/shopping.png') :
            expmodel.type == 'Travel' ? Image.asset('assets/Images/car.png') :
            expmodel.type == 'Movies' ? Image.asset('assets/Images/cinema.png') :
            expmodel.type == 'settle' ? Image.asset('assets/Images/cash.png') :
            Image.asset('assets/Images/others.png')
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 20),
                children: <TextSpan>[
                  TextSpan(
                      text: expmodel.paidBy == UserStore.uid
                          ? 'You'
                          : UIDN(expmodel.paidBy),
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' added '),
                  TextSpan(
                      text: '"' + expmodel.title + '"',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            RichText(
              text: expmodel.paidBy == UserStore.uid
                  ? TextSpan(
                  style: TextStyle(color: Colors.green, fontSize: 17),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'You',
                    ),
                    TextSpan(text: ' get back '),
                    TextSpan(
                      text:
                      '\u{20B9}${(expmodel.amount - expmodel.owe[UserStore.uid]!).toStringAsFixed(2)}',
                    ),
                  ])
                  : TextSpan(
                style: TextStyle(color: Colors.orange, fontSize: 17),
                children: <TextSpan>[
                  TextSpan(text: 'You'),
                  TextSpan(text: ' owe \u{20B9}'),
                  TextSpan(
                    text: expmodel.owe[UserStore.uid]?.toStringAsFixed(2),
                  ),
                ],
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text:
                            DateFormat('dd MMM, hh:mm aaa').format(expmodel.date),
                        style: TextStyle(color: Colors.black87,fontSize: 10)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
