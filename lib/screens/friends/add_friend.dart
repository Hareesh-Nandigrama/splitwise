import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/screens/home.dart';


import '../../constants/colors.dart';
import '../../firebase/firestore.dart';
import '../../functions/pop_up.dart';
import '../../stores/common_store.dart';
import '../../widgets/fields/fields.dart';

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
    var commonStore = context.read<CommonStore>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Friend"),
          leading: IconButton(
            icon: Icon(Icons.chevron_left_sharp),
            onPressed: () {
              commonStore.reload();
              Navigator.of(context).pushReplacementNamed(HomeScreen.id);
            },
          ),
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
                    String response = await FireStrMtd().addFriend(
                      email: emailC.text,
                    );
                    setState(() {
                      isLoading = false;
                    });
                    if (!mounted) return;
                    popUp(
                        response,
                        context,
                        2,
                        500,
                        response == "Added as Friend"
                            ? Colors.green
                            : Colors.red);
                    setState(() {
                      emailC.text = "";
                      commonStore.reload();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(320, 0),
                      padding: const EdgeInsets.all(10),
                      backgroundColor: kgreen),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Add Friend'),
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
