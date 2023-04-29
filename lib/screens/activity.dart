import 'package:flutter/material.dart';
import 'package:splitwise/firebase/firestore.dart';

import '../models/expense_model.dart';
import '../stores/user_store.dart';
import '../widgets/activity_tile.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Activity', style: TextStyle(fontSize: 25),),
            FutureBuilder(
              future: FireStrMtd().getActivity(),
                builder: (context,snapshot){
                if(!snapshot.hasData)
                  {
                    return CircularProgressIndicator();
                  }
              return Column(
                children: [
                  for(ExpenseModel e in snapshot.data!)
                    ActivityTile(expmodel: e)
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
