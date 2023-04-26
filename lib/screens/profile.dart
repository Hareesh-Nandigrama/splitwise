import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splitwise/firebase/auth.dart';
import 'package:splitwise/screens/authentication/welcome.dart';

import '../functions/pop_up.dart';
import '../widgets/fields/fields.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameC = TextEditingController();
  TextEditingController userC = TextEditingController();
  TextEditingController webC = TextEditingController();
  TextEditingController bioC = TextEditingController();

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
              children: [
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

            InField('Username', false, nameC, 0, 1),
            InField('Email', false, userC, 0, 1),
            InField('Phone Number', false, webC, 0, 1),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 0, 5, 25),
              child: OutlinedButton(
                onPressed: () {
                  AuthMtds().logout();
                  Navigator.pushReplacementNamed(context, FirstPage.id);
                },
                child: Text(
                  'Logout',
                  style: const TextStyle(color: Colors.red),
                ),
                style: OutlinedButton.styleFrom(
                    primary: Colors.red,
                    minimumSize: const Size(380, 60),
                    padding: const EdgeInsets.all(10),
                    side: const BorderSide(
                      color: Colors.red,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
