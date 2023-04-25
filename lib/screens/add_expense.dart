import 'package:flutter/material.dart';

import '../widgets/fields/autocomplete_field.dart';

class AddExpensePage extends StatefulWidget {
  static const String id = '/activity';
  const AddExpensePage({Key? key}) : super(key: key);

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {

  TextEditingController name = TextEditingController();
  TextEditingController amount = TextEditingController();
  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Add Expense"),
            leading: IconButton(onPressed: () {Navigator.of(context).pop();}, icon: Icon(Icons.chevron_left_sharp),),
            actions: [
              IconButton(onPressed: (){
                if(key.currentState!.validate())
                  {

                  }
              }, icon: Icon(Icons.check))
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: key,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,5,15,5),
                    child: CustomTextField(
                      hintText: 'Title',
                      validator: (s) {
                        if (name.text == null || name.text == '') {
                          return "Field cant be empty";
                        }
                        return null;
                      },
                      controller: name,
                      isNecessary: true,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,5,15,5),
                    child: CustomTextField(
                      hintText: 'Amount',
                      validator: (s) {
                        if (amount.text == null || amount.text == '') {
                          return "Field cant be empty";
                        }
                        return null;
                      },
                      controller: amount,
                      isNecessary: true,
                    ),
                  )
                ]


              ),
            ),
          ),
    ));
  }
}
