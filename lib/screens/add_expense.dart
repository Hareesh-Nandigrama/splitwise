import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../firebase/firestore.dart';
import '../functions/pop_up.dart';
import '../stores/user_store.dart';
import '../widgets/fields/autocomplete_field.dart';
import '../widgets/fields/fields.dart';

class AddExpensePage extends StatefulWidget {
  static const String id = '/activity';
  const AddExpensePage({Key? key}) : super(key: key);

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {

  TextEditingController name = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController email = TextEditingController();
  Map<String,TextEditingController> tmp = {
    UserStore.email : TextEditingController(text: '0'),
  };
  List<String> people = [UserStore.email];
  void split()
  {
    if(amount.text == '' || amount.text.isEmpty)
    {
      return;
    }
    int size = tmp.keys.length;
    double amt = double.parse(amount.text);
    double share = amt/size;
    for(var key in tmp.keys)
    {
      tmp[key]!.text = share.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left_sharp),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: const Text("Add Expense"),
        actions: [
          IconButton(onPressed: () async {
            Map<String, dynamic> data = {};
            data['paidBy'] = UserStore.email;
            data['title'] = name.text;
            data['amount'] = amount.text;
            data['owe'] = {};
            for(var person in tmp.keys)
              {
                data['owe'][person] = double.parse(tmp[person]!.text);
              }
            print(data);
            //String response = await FireStrMtd().createNonGroupExpense();
          }, icon: Icon(Icons.save))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InField('Expense Title', false, name, 0, 0),
                InField('Amount', false, amount, 10, 0),
                InField("People Involved", false, email,0,0),
                ElevatedButton(
                  onPressed: () async {

                    if(UserStore.friends.contains(email.text))
                    {
                      if(people.contains(email.text))
                      {
                        popUp("Already Added", context, 1, 500, Colors.red);
                        email.text = '';
                      }
                      else if(email.text == '')
                      {
                        popUp("Cannot be empty", context, 1, 500, Colors.red);
                      }
                      else
                      {
                        people.add(email.text);
                        tmp[email.text] = TextEditingController(text: '0');
                        setState(() {
                          email.text = '';
                        });
                        popUp("Added", context, 1, 500, Colors.green);
                      }
                    }
                    else
                    {
                      email.text = '';
                      popUp("Not A Friend", context, 1, 500, Colors.red);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(320, 0),
                      padding: const EdgeInsets.all(10),
                      backgroundColor: kgreen),
                  child:
                  const Text('Add Friend'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    split();
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(320, 0),
                      padding: const EdgeInsets.all(10),
                      backgroundColor: kgreen),
                  child:
                  const Text('Split Equally'),
                ),
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("People Added", style: TextStyle(color: Colors.black),),
                    ),
                    for(var user in people)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(user),
                            Expanded(child: Container(),),
                            SizedBox(
                                width: 200,
                                child: TextFormField(controller: tmp[user], )),
                            IconButton(onPressed: (){
                              if(user != UserStore.email)
                                {
                                  people.remove(user);
                                  tmp.remove(user);
                                  setState(() {
                                  });
                                }

                            }, icon: Icon(Icons.clear, color: Colors.red,))
                          ],
                        ),
                      )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
