import 'package:flutter/material.dart';
import 'package:splitwise/functions/email_to_uid.dart';
import 'package:splitwise/models/expense_model.dart';
import 'package:intl/intl.dart';
import 'package:splitwise/stores/user_store.dart';

class ExpenseDetail extends StatelessWidget {
  final ExpenseModel expmodel;
  const ExpenseDetail({Key? key, required this.expmodel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0,20,8,20),
                child: Row(
                  children: [
                    Expanded(child: Container(),flex: 1,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text(expmodel.title, style: TextStyle(fontSize: 25),),
                        Text('\u{20B9}${expmodel.amount.toStringAsFixed(2)}',style: TextStyle(fontSize: 35),),
                        Text(DateFormat('yMMMMd').format(expmodel.date),style: TextStyle(fontSize: 15),),
                      ],
                    ),
                    Expanded(child: Container(),flex: 3,),
                  ],
                ),

              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child:  expmodel.type == 'Food' ? Image.asset('assets/Images/food.png') :
                  expmodel.type == 'Shopping' ? Image.asset('assets/Images/shopping.png') :
                  expmodel.type == 'Travel' ? Image.asset('assets/Images/car.png') :
                  expmodel.type == 'Movies' ? Image.asset('assets/Images/cinema.png') :
                  Image.asset('assets/Images/others.png'),
                ),
                title: Text('${UIDN(expmodel.paidBy)} paid \u{20B9}${expmodel.amount}'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(93.0,8,8,8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for(var person in expmodel.owe.keys)
                        person != UserStore.uid ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Text('${UIDN(person)} owes \u{20B9}${expmodel.owe[person]?.toStringAsFixed(2)}', style: TextStyle(color: Colors.black54),),
                        ) : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Text('You owe \u{20B9}${expmodel.owe[person]?.toStringAsFixed(2)}',style: TextStyle(color: Colors.black54),),
                        )

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
