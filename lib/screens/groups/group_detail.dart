import 'package:flutter/material.dart';
import 'package:splitwise/widgets/fields/expenses_tile.dart';

class GroupDetails extends StatefulWidget {
  const GroupDetails({Key? key}) : super(key: key);

  @override
  State<GroupDetails> createState() => _GroupDetailsState();
}

class _GroupDetailsState extends State<GroupDetails> {
  int type = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.chevron_left_sharp),onPressed: (){
          Navigator.of(context).pop();
        },),
        title: Text('Group Name'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            type > 0
                ? Text(
              'You are owed $type overall',
              style: TextStyle(color: Colors.green, fontSize: 20),
            )
                : type == 0
                ? Text(
              'settled up',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            )
                : Text(
              'You owe $type overall',
              style:
              TextStyle(color: Colors.orange, fontSize: 20),
            ),
            ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(minimumSize: const Size(320,0), padding: const EdgeInsets.all(10), backgroundColor: Colors.orange),
              child: const Text('Settle up'),
            ),
            ExpenseTile(),
            ExpenseTile(),
            ExpenseTile(),
            ExpenseTile(),
            ExpenseTile(),
            ExpenseTile(),
            ExpenseTile(),
            ExpenseTile(),
            ExpenseTile(),

          ],
        ),
      ),
    );
  }
}
