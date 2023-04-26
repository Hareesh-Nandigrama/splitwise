import 'package:flutter/material.dart';
import 'package:splitwise/widgets/group_tile.dart';

class GroupHome extends StatelessWidget {
  static const String id = '/groupHome';
  const GroupHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GroupTile(type: 5),
          GroupTile(type: 0),
          GroupTile(type: -5),
        ],
      ),
    );
  }
}
