import 'package:flutter/material.dart';
import 'package:splitwise/firebase/firestore.dart';
import 'package:splitwise/widgets/fields/fields.dart';

import '../../constants/colors.dart';

class AddFriendPage extends StatefulWidget {
  static const String id = '/addfriend';
  const AddFriendPage({Key? key}) : super(key: key);

  @override
  State<AddFriendPage> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {

  TextEditingController emailC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Friend"),
          leading: IconButton(icon: Icon(Icons.chevron_left_sharp),onPressed: (){
            Navigator.of(context).pop();
          },),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: Container(),
                ),
                SizedBox(
                    width: 320,
                    child: InField('Friend Email', false, emailC, 0, 1)),
                ElevatedButton(
                  onPressed: () async {
                    var response = await FireStrMtd().addFriend( email: emailC.text,);
                  },
                  style: ElevatedButton.styleFrom(minimumSize: const Size(320,0), padding: const EdgeInsets.all(10), backgroundColor: kgreen),
                  child: const Text('Add Friend'),
                ),
                Expanded(
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
