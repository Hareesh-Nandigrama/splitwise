import 'package:flutter/material.dart';
import 'package:splitwise/functions/email_to_uid.dart';
import 'package:splitwise/models/expense_model.dart';
import 'package:intl/intl.dart';
import 'package:splitwise/stores/user_store.dart';

class ExpenseDetail extends StatelessWidget {
  final ExpenseModel expModel;
  const ExpenseDetail({Key? key, required this.expModel}) : super(key: key);

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
                        Text(expModel.title, style: TextStyle(fontSize: 25),),
                        Text('\u{20B9}${expModel.amount.toStringAsFixed(2)}',style: TextStyle(fontSize: 35),),
                        Text(DateFormat('yMMMMd').format(expModel.date),style: TextStyle(fontSize: 15),),
                      ],
                    ),
                    Expanded(child: Container(),flex: 3,),
                  ],
                ),

              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage('https://media.istockphoto.com/id/517188688/photo/mountain-landscape.jpg?s=612x612&w=0&k=20&c=A63koPKaCyIwQWOTFBRWXj_PwCrR4cEoOw2S9Q7yVl8='),
                ),
                title: Text('${UIDN(expModel.paidBy)} paid \u{20B9}${expModel.amount}'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(93.0,8,8,8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for(var person in expModel.owe.keys)
                        person != UserStore.uid ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Text('${UIDN(person)} owes \u{20B9}${expModel.owe[person]?.toStringAsFixed(2)}', style: TextStyle(color: Colors.black54),),
                        ) : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Text('You owe \u{20B9}${expModel.owe[person]?.toStringAsFixed(2)}',style: TextStyle(color: Colors.black54),),
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
