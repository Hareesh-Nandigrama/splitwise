import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/screens/home.dart';
import '../../constants/colors.dart';
import '../../firebase/firestore.dart';
import '../../functions/email_to_uid.dart';
import '../../functions/pop_up.dart';
import '../../models/group_model.dart';
import '../../stores/common_store.dart';
import '../../stores/user_store.dart';
import '../../widgets/fields/fields.dart';

class AddExpensePage extends StatefulWidget {
  final GroupModel grpModel;
  const AddExpensePage({Key? key, required this.grpModel, }) : super(key: key);

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
  double tot = 0;
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

  double checkSum()
  {
    double a = double.parse(amount.text);
    double counter = 0;
    for(var key in tmp.keys)
      {
        if(tmp[key]!.text == "")
          {
            popUp("Fields cannot be empty", context, 1, 500, Colors.red);
            break;
          }
        else
          {
            counter += double.parse(tmp[key]!.text);
          }
      }

    a = a - counter;
    return a;
  }

  void addPerson()
  {
    if(email.text == '')
    {
      popUp("Cannot be empty", context, 1, 500, Colors.red);
      return;
    }
    else if(people.contains(email.text))
    {
      popUp("Already Added", context, 1, 500, Colors.red);
      return;
    }
    else
    {
      if(widget.grpModel.creator == 'ADMIN__ADMIN')
      {
        if(UserStore.friends.containsKey(EUID(email.text)))
        {
          people.add(email.text);
          tmp[email.text] = TextEditingController();
          popUp("Added", context, 1, 500, Colors.green);
          setState(() {});
          return;

        }
        else
        {
          popUp("Not a Friend", context, 1, 500, Colors.red);
          return;
        }
      }
      else
      {
        if(widget.grpModel.balances.containsKey(EUID(email.text)))
        {
          people.add(email.text);
          tmp[email.text] = TextEditingController();
          popUp("Added", context, 1, 500, Colors.green);
          setState(() {});
          return;
        }
        else
        {
          popUp("Not Part of the Group", context, 1, 500, Colors.red);
          return;
        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left_sharp),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: const Text("Add Expense"),
          actions: [
            IconButton(onPressed: () async {
              double x = checkSum();
              if(x > 0.01 || x < -0.01)
                {
                  popUp("$x amount has not been accounted correctly", context, 1, 500, Colors.red);
                  return;
                }
              String expenseID = "Expenses${UserStore.uid}CC${DateTime.now().month}CC${DateTime.now().day}CC${DateTime.now().hour}CC${DateTime.now().minute}CC${DateTime.now().second}";
              Map<String, dynamic> data = {};
              data['paidBy'] = UserStore.uid;
              data['title'] = name.text;
              data['amount'] = double.parse(amount.text);
              data['owe'] = {};
              data['date'] = DateTime.now();
              data['expenseID'] = expenseID;
              data['groupID'] = widget.grpModel.id;
              for(var person in tmp.keys)
                {
                  data['owe'][EUID(person)] = double.parse(tmp[person]!.text);
                }
              String response = '';
              if(widget.grpModel.balances.keys.length == 1)
                {
                   response = await FireStrMtd().createNonGroupExpense(data);
                }
              else
                {
                  response = await FireStrMtd().createGroupExpense(data);
                }

              if (!mounted) return;
              if(response == "Success")
                {
                  commonStore.reload();
                  Navigator.of(context).pushReplacementNamed(HomeScreen.id);
                  popUp("Expense Added", context, 1, 500, Colors.green);
                }
              else
                {
                  popUp(response, context, 1, 500, Colors.red);
                }
            }, icon: const Icon(Icons.save))
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
                  InField("Add People Involved", false, email,0,0),
                  ElevatedButton(
                    onPressed: (){
                      addPerson();
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(user == UserStore.email ?"You" :UIDN(EUID(user)), style: TextStyle(fontSize: 15),),
                                  Text(user, style: TextStyle(fontSize: 10),),
                                ],
                              ),
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

                              }, icon: const Icon(Icons.clear, color: Colors.red,))
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
      ),
    );
  }
}
