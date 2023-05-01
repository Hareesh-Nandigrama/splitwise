import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/firebase/auth.dart';
import 'package:splitwise/screens/authentication/welcome.dart';
import 'package:splitwise/stores/common_store.dart';
import 'package:splitwise/stores/mapping_store.dart';

import '../constants/enums.dart';
import '../firebase/storage.dart';
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

  String imurl = MappingStore.dp[UserStore.uid] ?? "DEFAULTDP";
  Uint8List? dp;
  bool isUpdating = false;


  //Function to select an image from gallery or camera and store it in dp
  selectImage(ImageSource temp) async {
    Uint8List now = await pickImage(temp) ?? 'apple';
    if(now == 'apple')
      {
        return;
      }
    setState(() {
      dp = now;
    });
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {return await _file.readAsBytes();}
  }

  //Function to update dp
  UpdateDp() async {
setState(() {
  isUpdating = true;
});
      if(dp != null)
      {
        String newdp = await StorageMtds().uploadPost(path: '', file: dp!);
        setState(() {imurl = newdp;});
      }
setState(() {
  isUpdating = false;
});
  }

  Widget bottomSheet(BuildContext context) {
    return Container( height: 100.0,  width: MediaQuery.of(context).size.width,  margin: const EdgeInsets.symmetric( horizontal: 20, vertical: 20,),
      child: Column( children: <Widget>[
        const Text( "Choose Profile photo",  style: TextStyle(fontSize: 20.0,),),
        const SizedBox(height: 20,),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
          TextButton.icon( icon: const Icon(Icons.camera), onPressed: () async { Navigator.pop(context);await selectImage(ImageSource.camera); await UpdateDp(); }, label: const Text("Camera"),),
          TextButton.icon(icon: const Icon(Icons.image), onPressed: () async { Navigator.pop(context); await selectImage(ImageSource.gallery); await UpdateDp();}, label: const Text("Gallery"),),
          //TextButton.icon(icon: const Icon(Icons.delete, color: Colors.red,), onPressed: () {setState(() {dp = null; imurl = 'DEFAULTDP'; });}, label: const Text("Remove", style: TextStyle(color: Colors.red),),),
        ]
        )],),);}

  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
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
                isUpdating? LinearProgressIndicator(
                  color: Colors.blue,
                ): Container(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,13,0,0),
                  child: Container(
                    child: dp !=null ?CircleAvatar(radius: 50, backgroundImage: MemoryImage(dp!),):
                    imurl == 'DEFAULTDP' ? CircleAvatar(radius: 50, backgroundImage:AssetImage('assets/Images/profile.png')):
                    CircleAvatar(radius: 50, backgroundImage:NetworkImage(imurl)),
                  ),
                ),

                TextButton(
                  onPressed: (){showModalBottomSheet(isDismissible: true, context: context, builder: ((builder) => bottomSheet(context)),);},
                  child: const Text('Change Profile Photo'),
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
                          if (!mounted) return;
                          Navigator.pushReplacementNamed(context, FirstPage.id);
                          UserStore.clear();
                          commonStore.setPage(Pages.groups);
                        }
                      else
                        {
                          popUp(response, context, 1, 500, Colors.red);
                        }

                    },
                    style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red, minimumSize: const Size(380, 60),
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
