import 'package:flutter/material.dart';
import 'package:splitwise/screens/groups/group_detail.dart';

import '../models/group_model.dart';

class GroupTile extends StatelessWidget {
  final GroupModel grpModel;
  int type = 3;
  GroupTile({Key? key, required this.grpModel, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => GroupDetails(grpModel: grpModel,)));
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
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    grpModel.title,
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  type > 0
                      ? Text(
                          'You are owed $type',
                          style: TextStyle(color: Colors.green, fontSize: 20),
                        )
                      : type == 0
                          ? Text(
                              'settled up',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20),
                            )
                          : Text(
                              'You owe ${-1 * type}',
                              style:
                                  TextStyle(color: Colors.orange, fontSize: 20),
                            )
                ],
              )
            ],
          )),
    );
  }
}
