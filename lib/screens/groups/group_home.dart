import 'package:flutter/material.dart';
import 'package:splitwise/firebase/firestore.dart';
import 'package:splitwise/widgets/group_tile.dart';
import '../../models/group_model.dart';
import '../../stores/user_store.dart';

class GroupHome extends StatelessWidget {
  static const String id = '/groupHome';
  const GroupHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: FireStrMtd().getGroups(),
        builder: (context,snapshot) {
          if(snapshot.hasData)
            {
              var dat = snapshot.data as Map<String, GroupModel>;
              return Column(
                children: [
                  for(GroupModel grp in dat.values)
                    GroupTile(grpModel: grp,)
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
