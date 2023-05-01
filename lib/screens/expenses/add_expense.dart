import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/screens/home.dart';
import 'package:splitwise/widgets/fields/drop_down.dart';
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
  Map<String,TextEditingController> tmp = {
    UserStore.email : TextEditingController(text: '0'),
  };
  List<String> people = [UserStore.email];
  double tot = 0;
  bool isPercentage = false;
  bool isLoading = false;
  String? cat;
  String? friend;
  void split()
  {
    if(amount.text == '' || amount.text.isEmpty)
    {
      popUp("Amount cannot be empty",context,1,500,Colors.red);
      return;
    }
    int size = tmp.keys.length;
    double amt = double.parse(amount.text);
    if(isPercentage)
      {
        amt = 100;
      }

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
    if(isPercentage)
      {
        a = 100;
      }
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
    if(friend == null)
      {
        popUp("Cannot be empty", context, 1, 500, Colors.red);
        return;
      }
    String a = UIDE(NUID(friend!));
    if(a == '')
    {
      popUp("Cannot be empty", context, 1, 500, Colors.red);
      return;
    }
    else if(people.contains(a))
    {
      popUp("Already Added", context, 1, 500, Colors.red);
      return;
    }
    else
    {
      if(widget.grpModel.creator == 'ADMIN__ADMIN')
      {
        if(UserStore.friends.containsKey(EUID(a)))
        {
          people.add(a);
          tmp[a] = TextEditingController();
          popUp("Added", context, 1, 500, Colors.green);
          friend = null;
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
        if(widget.grpModel.balances.containsKey(EUID(a)))
        {
          people.add(a);
          tmp[a] = TextEditingController();
          popUp("Added", context, 1, 500, Colors.green);
          friend = null;
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
              if(isLoading)
                {
                  return;
                }
              setState(() {
                isLoading = true;
              });
              if(name.text == '' || name.text == null)
                {
                  popUp("Enter Title", context, 1, 500, Colors.red);
                  setState(() {
                    isLoading = false;
                  });
                  return;
                }
              if(amount.text == '' || amount.text == null)
              {
                popUp("Enter Amount", context, 1, 500, Colors.red);
                setState(() {
                  isLoading = false;
                });
                return;
              }
              if(cat == null)
                {
                  popUp("Select a category", context, 1, 500, Colors.red);
                  setState(() {
                    isLoading = false;
                  });
                  return;
                }
              double x = checkSum();
              if(x > 0.01 || x < -0.01)
                {
                  popUp("$x amount has not been accounted correctly", context, 1, 500, Colors.red);
                  setState(() {
                    isLoading = false;
                  });
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
              data['type'] = cat;
              for(var person in tmp.keys)
                {
                  if(isPercentage)
                    {
                      data['owe'][EUID(person)] = double.parse(tmp[person]!.text) * data['amount'] / 100;
                    }
                  else
                    {
                      data['owe'][EUID(person)] = double.parse(tmp[person]!.text);
                    }
                }
              String response = '';
              print(data);
              if(widget.grpModel.balances.keys.length == 1)
                {
                   response = await FireStrMtd().createNonGroupExpense(data);
                }
              else
                {
                  response = await FireStrMtd().createGroupExpense(data);
                }
              setState(() {
                isLoading = false;
              });

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
                  isLoading ? LinearProgressIndicator() : Container(),
                  InField('Expense Title', false, name, 0, 0),
                  InField('Amount', false, amount, 10, 0),
                  SizedBox(
                    width: 320,
                    child: CustomDropDown(items: UserStore.getFriends(), hintText: 'Add People Involved', onChanged: (String val){
                      setState(() {
                       friend = val;
                      });

                    },
                      value: friend,),
                  ),
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
                  SizedBox(
                    width: 320,
                    child: CustomDropDown(items: ['Food','Shopping','Travel','Movies','Others'], hintText: 'Category', onChanged: (String val){
                      setState(() {
                        cat = val;
                      });

                    },
                    value: cat,),
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      const Text("Is Percentage ?"),
                      Checkbox(value: isPercentage, onChanged: (a){
                        isPercentage = !isPercentage;
                        setState(() {
                        });
                      }),
                      Expanded(
                        child: Container(),
                      ),
                    ],
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
