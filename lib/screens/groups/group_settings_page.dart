import 'package:flutter/material.dart';
import '../../functions/email_to_uid.dart';
import '../../models/group_model.dart';
import '../../stores/mapping_store.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                'Group Members',
                style: TextStyle(fontSize: 15),
              ),
              for (var people in widget.model.balances.keys)
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ListTile(
                    title: Text(UIDN(people)),
                    trailing: Text(UIDE(people)),
                    leading: MappingStore.dp[people] == null
                        ? const CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage('assets/Images/profile.png'),
                          )
                        : CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(MappingStore.dp[people]!),
                          ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
