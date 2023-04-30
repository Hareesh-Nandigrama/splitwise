import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/firebase/firestore.dart';
import 'package:splitwise/stores/common_store.dart';

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
    var commonStore = context.read<CommonStore>();
    return Observer(
      builder: (context) {
        print(commonStore.counter);
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Activity', style: TextStyle(fontSize: 25),),
                ),
                FutureBuilder(
                  future: FireStrMtd().getActivity(),
                    builder: (context,snapshot){
                    if(!snapshot.hasData)
                      {
                        return CircularProgressIndicator();
                      }
                  return Column(
                    children: [
                      for(ExpenseModel e in snapshot.data!.reversed)
                        ActivityTile(expmodel: e)
                    ],
                  );
                })
              ],
            ),
          ),
        );
      }
    );
  }
}
