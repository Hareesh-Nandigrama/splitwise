import 'package:flutter/material.dart';
import 'package:splitwise/widgets/friend_tile.dart';
import '../../firebase/auth.dart';
import '../../firebase/firestore.dart';
import '../../models/user_groups_model.dart';
import '../../stores/user_store.dart';

class FriendHome extends StatefulWidget {
  const FriendHome({Key? key}) : super(key: key);

  @override
  State<FriendHome> createState() => _FriendHomeState();
}

class _FriendHomeState extends State<FriendHome> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FireStrMtd().saveUserData(),
        builder: (context,snapshot) {
          if(snapshot.hasData)
          {
            double bal = 0;
            List<String> keys = [];
            for(String key in UserStore.friends.keys)
              {
                keys.add(key);
                bal += UserStore.friends[key]!.owe;
              }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    bal == 0 ? const Text('Overall you are settled', style: TextStyle(color: Colors.black,fontSize: 20),):
                        bal > 0 ? Text('Overall, you are owed \u{20B9}${bal.toStringAsFixed(2)}', style: TextStyle(color: Colors.green,fontSize: 20),):
                            Text('Overall, you owe \u{20B9}${bal.abs().toStringAsFixed(2)}', style: TextStyle(color: Colors.orange,fontSize: 20),),
                    const SizedBox(height: 15,),
                    for(String key in UserStore.friends.keys)
                      FriendTile(key)
                  ],
                ),
              ),
            );
          }
          else
          {
            return CircularProgressIndicator();
          }

        }
    );
  }
}
