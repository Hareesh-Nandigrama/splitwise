import 'package:flutter/material.dart';
import 'package:splitwise/firebase/firestore.dart';
import 'package:splitwise/functions/pop_up.dart';
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
  bool isLoading = false;

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
                    setState(() {
                      isLoading = true;
                    });
                    String response = await FireStrMtd().addFriend( email: emailC.text,);
                    setState(() {
                      isLoading = false;
                    });
                    if(!mounted) return;
                    popUp(response, context, 1, 500, response == "Added as Friend"?  Colors.green : Colors.red);
                  },
                  style: ElevatedButton.styleFrom(minimumSize: const Size(320,0), padding: const EdgeInsets.all(10), backgroundColor: kgreen),
                  child: isLoading ? const CircularProgressIndicator(): const Text('Add Friend'),
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
