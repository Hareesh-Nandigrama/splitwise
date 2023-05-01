import 'package:flutter/material.dart';
import 'package:splitwise/firebase/firestore.dart';
import 'package:splitwise/functions/pop_up.dart';
import 'package:splitwise/screens/home.dart';
import 'package:splitwise/stores/user_store.dart';
import '../../constants/colors.dart';
import '../../functions/email_to_uid.dart';
import '../../models/group_model.dart';
import '../../stores/mapping_store.dart';
import '../../widgets/fields/fields.dart';

class GroupSettingsPage extends StatefulWidget {
  final GroupModel model;
  const GroupSettingsPage({Key? key, required this.model}) : super(key: key);

  @override
  State<GroupSettingsPage> createState() => _GroupSettingsPageState();
}

class _GroupSettingsPageState extends State<GroupSettingsPage> {
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group Settings"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                'Group Members',
                style: TextStyle(fontSize: 15),
              ),
              InField("Add friend (email)", false, email,0,0),
              ElevatedButton(
                onPressed: () async {
                  if(email.text == '' || email.text == null)
                    {
                      popUp('Email cannot be empty', context, 1, 500, Colors.red);
                      return;
                    }
                  else if(widget.model.balances.keys.contains(EUID(email.text)))
                    {
                      popUp('Already in group', context, 1, 500, Colors.red);
                      return;
                    }
                  else if(!UserStore.friends.keys.contains(EUID(email.text)))
                    {
                      popUp('Not a Friend', context, 1, 500, Colors.red);
                      return;
                    }
                  String resp = await FireStrMtd().addToGroup(widget.model,email.text);
                  if(resp == 'Success')
                    {
                      popUp('Friend Added', context, 1, 500, Colors.red);
                      Navigator.of(context).pushReplacementNamed(HomeScreen.id);
                    }
                  else
                    {
                      popUp(resp, context, 1, 500, Colors.red);
                    }
                },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(320, 0),
                    padding: const EdgeInsets.all(10),
                    backgroundColor: kgreen),
                child:
                const Text('Add Friend'),
              ),
              for (var people in widget.model.balances.keys)
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListTile(
                    title: Text(UIDN(people)),
                    trailing: Text(UIDE(people)),
                    leading: MappingStore.dp[people] == null
                        ? const CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage('assets/Images/profile.png'),
                          )
                        : CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(MappingStore.dp[people]!),
                          ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
