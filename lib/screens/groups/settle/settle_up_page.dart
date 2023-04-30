import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/models/group_model.dart';
import 'package:splitwise/stores/user_store.dart';
import 'package:splitwise/widgets/friend_tile.dart';

import '../../../functions/email_to_uid.dart';
import '../../../stores/common_store.dart';
import 'settle_confirm_page.dart';

class SettleUpPage extends StatefulWidget {
  final GroupModel model;
  const SettleUpPage({Key? key, required this.model}) : super(key: key);

  @override
  State<SettleUpPage> createState() => _SettleUpPageState();
}

class _SettleUpPageState extends State<SettleUpPage> {
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Select a balance to settle'),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    for(String person in widget.model.balances[UserStore.uid]!.keys)
                      GestureDetector(
                        onTap: ()
                        {
                          double bal = widget.model.balances[UserStore.uid]![person]!;
                          if(bal == 0)
                            {
                              return;
                            }
                          else if(bal < 0)
                            {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SettleConfirmPage(from: UserStore.uid,to: person, groupId: widget.model.id, amount: bal,)));
                            }
                          else
                            {

                            }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: const CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage('https://media.istockphoto.com/id/517188688/photo/mountain-landscape.jpg?s=612x612&w=0&k=20&c=A63koPKaCyIwQWOTFBRWXj_PwCrR4cEoOw2S9Q7yVl8='),
                            ),
                            trailing: getTrial(widget.model.balances[UserStore.uid]![person]!),
                            title: Text(UIDN(person)),

                          ),
                        ),
                      ),
                  ],
                ),
              ),
        ));
  }
}
