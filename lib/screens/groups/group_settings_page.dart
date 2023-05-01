import 'package:flutter/material.dart';
import '../../models/group_model.dart';

class GroupSettingsPage extends StatefulWidget {
  final GroupModel model;
  const GroupSettingsPage({Key? key, required this.model}) : super(key: key);

  @override
  State<GroupSettingsPage> createState() => _GroupSettingsPageState();
}

class _GroupSettingsPageState extends State<GroupSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group Settings"),
      ),
    );
  }
}
