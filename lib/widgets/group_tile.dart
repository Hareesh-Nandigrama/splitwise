import 'package:flutter/material.dart';
import 'package:splitwise/screens/groups/group_detail.dart';

class GroupTile extends StatelessWidget {
  int type = 3;
  final String groupID;
  GroupTile({Key? key, required this.groupID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => GroupDetails()));
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
                    'Btech Credits',
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
