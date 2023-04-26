import 'package:flutter/material.dart';

import '../../widgets/fields/fields.dart';

class NewGroupPage extends StatefulWidget {
  static const String id = '/newGroup';
  const NewGroupPage({Key? key}) : super(key: key);

  @override
  State<NewGroupPage> createState() => _NewGroupPageState();
}

class _NewGroupPageState extends State<NewGroupPage> {
  TextEditingController group = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.chevron_left_sharp),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Text("Create Group"),
      ),
      body: Column(
        children: [
          InField('Group Name', false, group, 0, 0),
        ],
      ),
    );
  }
}
