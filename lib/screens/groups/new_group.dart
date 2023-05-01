import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/stores/common_store.dart';
import 'package:splitwise/stores/user_store.dart';


import '../../constants/colors.dart';
import '../../firebase/firestore.dart';
import '../../functions/email_to_uid.dart';
import '../../functions/pop_up.dart';
import '../../widgets/fields/drop_down.dart';
import '../../widgets/fields/fields.dart';

class NewGroupPage extends StatefulWidget {
  static const String id = '/newGroup';
  const NewGroupPage({Key? key}) : super(key: key);

  @override
  State<NewGroupPage> createState() => _NewGroupPageState();
}

class _NewGroupPageState extends State<NewGroupPage> {
  TextEditingController group = TextEditingController();
  List<String> people = [];
  String? friend;

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
          title: const Text("Create Group"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InField('Group Name', false, group, 0, 0),
                  SizedBox(
                    width: 320,
                    child: CustomDropDown(items: UserStore.getFriends(), hintText: 'Add Friend', onChanged: (String val){
                      setState(() {
                        friend = val;
                      });

                    },
                      value: friend,),
                  ),
                  ElevatedButton(
                    onPressed: () async {
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
                      if(UserStore.friends.keys.contains(EUID(a)))
                        {
                          if(people.contains(a))
                            {
                              popUp("Already Added", context, 1, 500, Colors.red);
                              friend = null;
                            }
                          else
                            {
                              people.add(a);
                              friend = null;
                              popUp("Added", context, 1, 500, Colors.green);
                            }
                        }
                      else
                        {
                         friend = null;
                          popUp("Not A Friend", context, 1, 500, Colors.red);
                        }
                      setState(() {});

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
                              commonStore.reload();
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
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("People Added", style: TextStyle(color: Colors.black),),
                      ),
                      for(var user in people)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(UIDN(EUID(user))),
                            subtitle: Text(user),
                            trailing: IconButton(onPressed: (){
                              people.remove(user);
                              setState(() {
                              });
                            }, icon: const Icon(Icons.clear, color: Colors.red,)),
                          )

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
