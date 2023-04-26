import 'package:flutter/material.dart';
import 'package:splitwise/firebase/auth.dart';
import 'package:splitwise/firebase/local_storage.dart';
import 'package:splitwise/screens/authentication/welcome.dart';

import '../functions/pop_up.dart';
import '../stores/user_store.dart';
import '../widgets/fields/fields.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController usernameC = TextEditingController(text: UserStore.username);
  TextEditingController emailC = TextEditingController(text: UserStore.email);
  TextEditingController phonenumberC = TextEditingController(text: UserStore.phoneNumber);

  @override
  Widget build(BuildContext context) {
    return Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 25, 8, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "",
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    )
                  ],
                ),
                //true? LinearProgressIndicator(): Container(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                  child: Container(),
                ),

                InField('Username', false, usernameC, 0, 1),
                InField('Email', false, emailC, 0, 1),
                InField('Phone Number', false, phonenumberC, 0, 1),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 0, 5, 25),
                  child: OutlinedButton(
                    onPressed: () async {
                      String response = await AuthMtds().logout();
                      if (!mounted) return;
                      if(response == "Success")
                        {
                          await LocalStorage.instance.deleteRecord('userdata');
                          if (!mounted) return;
                          Navigator.pushReplacementNamed(context, FirstPage.id);
                          UserStore.clear();
                        }
                      else
                        {
                          popUp(response, context, 1, 500, Colors.red);
                        }

                    },
                    style: OutlinedButton.styleFrom(
                        primary: Colors.red,
                        minimumSize: const Size(380, 60),
                        padding: const EdgeInsets.all(10),
                        side: const BorderSide(
                          color: Colors.red,
                        )),
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
  }
}
