import 'package:flutter/material.dart';
import 'package:splitwise/firebase/auth.dart';
import 'package:splitwise/firebase/firestore.dart';
import 'package:splitwise/models/user_groups_model.dart';
import 'package:splitwise/stores/user_store.dart';
import 'package:splitwise/widgets/group_tile.dart';
import '../../models/group_model.dart';

class GroupHome extends StatelessWidget {
  static const String id = '/groupHome';
  const GroupHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: FireStrMtd().saveUserData(),
        builder: (context,snapshot) {
          if(snapshot.hasData)
            {
              print(UserStore.groups.values);
              return Column(
                children: [
                  for(UserGroupModel x in UserStore.groups.values)
                    GroupTile(userGrpModel: x,)
                ],
              );
            }
          else
            {
              return CircularProgressIndicator();
            }

        }
      ),
    );
  }
}
