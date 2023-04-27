import 'package:flutter/material.dart';
import 'package:splitwise/firebase/firestore.dart';
import 'package:splitwise/functions/pop_up.dart';
import 'package:splitwise/stores/user_store.dart';

import '../../constants/colors.dart';
import '../../widgets/fields/fields.dart';

class NewGroupPage extends StatefulWidget {
  static const String id = '/newGroup';
  const NewGroupPage({Key? key}) : super(key: key);

  @override
  State<NewGroupPage> createState() => _NewGroupPageState();
}

class _NewGroupPageState extends State<NewGroupPage> {
  TextEditingController group = TextEditingController();
  TextEditingController email = TextEditingController();
  List<String> people = [];
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
        title: Text("Create Group"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InField('Group Name', false, group, 0, 0),
                InField("Friend Name", false, email,0,0),
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
                    if(people.isNotEmpty)
                      {
                        String resp = await FireStrMtd().createGroup(people: people,title: group.text);
                        if(resp == "Success")
                          {
                            popUp('Group Created', context, 2, 0, Colors.green);
                            Navigator.of(context).pop();
                          }
                        else
                          {
                            popUp(resp, context, 2, 0, Colors.green);
                          }
                      }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(320, 0),
                      padding: const EdgeInsets.all(10),
                      backgroundColor: kgreen),
                  child:
                  const Text('Create Group'),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("People Added", style: TextStyle(color: Colors.black),),
                    ),
                    for(var user in people)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(user),
                            Expanded(child: Container(),),
                            IconButton(onPressed: (){
                              people.remove(user);
                              setState(() {
                              });
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
