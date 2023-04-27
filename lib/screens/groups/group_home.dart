import 'package:flutter/material.dart';
import 'package:splitwise/widgets/group_tile.dart';
import '../../stores/user_store.dart';

class GroupHome extends StatelessWidget {
  static const String id = '/groupHome';
  const GroupHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for(String grp in UserStore.groups)
            GroupTile(groupID: "Appke")
        ],
      ),
    );
  }
}
