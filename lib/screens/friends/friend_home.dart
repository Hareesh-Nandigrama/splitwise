import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/functions/friends_filter_function.dart';
import 'package:splitwise/models/user_friends_model.dart';
import 'package:splitwise/widgets/fields/filter.dart';
import 'package:splitwise/widgets/friend_tile.dart';
import '../../firebase/firestore.dart';
import '../../stores/common_store.dart';
import '../../stores/user_store.dart';

class FriendHome extends StatefulWidget {
  const FriendHome({Key? key}) : super(key: key);

  @override
  State<FriendHome> createState() => _FriendHomeState();
}

class _FriendHomeState extends State<FriendHome> {
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    return FutureBuilder(
        future: FireStrMtd().saveUserData(),
        builder: (context,snapshot) {
          if(snapshot.hasData)
          {
            return Observer(
              builder: (context) {
                double bal = 0;
                List<String> keys = [];
                Map<String, UserFriendModel> tmp= filterFriendsFunction(input: UserStore.friends, type: commonStore.type);
                for(String key in tmp.keys)
                {
                  keys.add(key);
                  bal += tmp[key]!.owe;
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
                        FilterBar(items: ['All','You Owe','Who Owe You','You are settled with'], hintText: 'People',index: 0,),
                        for(String key in tmp.keys)
                          FriendTile(key)
                      ],
                    ),
                  ),
                );
              }
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
