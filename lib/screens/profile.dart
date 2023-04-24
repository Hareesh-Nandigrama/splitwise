import 'package:flutter/material.dart';
import 'package:splitwise/firebase/auth.dart';
import 'package:splitwise/screens/authentication/welcome.dart';

import '../functions/pop_up.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        TextButton(
            onPressed: () async {
              String response = await AuthMtds().logout();
              if(response == 'Success')
                {
                  Navigator.of(context).pushReplacementNamed(FirstPage.id);
                }
              else
                {
                  popUp(response, context, 1, 500, Colors.redAccent);
                }
            },
            child: Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            )),
      ]),
    );
  }
}
