import 'package:flutter/material.dart';
import 'package:splitwise/screens/groups/group_detail.dart';

import '../models/user_groups_model.dart';


class GroupTile extends StatelessWidget {
  final UserGroupModel userGrpModel;
  GroupTile({Key? key, required this.userGrpModel, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double bal = userGrpModel.owe;
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => GroupDetails(userGrpModel: userGrpModel,)));
      },
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    child: Image.network(
                      "https://previews.agefotostock.com/previewimage/medibigoff/f687b83fd1c0e30b61a597e44f8a2147/esy-043436739.jpg",
                      height: 50,
                      width: 50,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userGrpModel.title,
                    style: const TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  bal > 0
                      ? Text(
                          'You are owed \u{20B9}${bal.toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.green, fontSize: 20),
                        )
                      : bal == 0
                          ? const Text(
                              'settled up',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20),
                            )
                          : Text(
                              'You owe \u{20B9}${(-1*bal).toStringAsFixed(2)}',
                              style:
                                  const TextStyle(color: Colors.orange, fontSize: 20),
                            )
                ],
              )
            ],
          )),
    );
  }
}
