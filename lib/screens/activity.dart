import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/firebase/firestore.dart';
import 'package:splitwise/functions/activity_filter_function.dart';
import 'package:splitwise/stores/common_store.dart';
import 'package:splitwise/widgets/fields/drop_down.dart';
import 'package:splitwise/widgets/fields/filter.dart';
import '../models/expense_model.dart';
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: 100,
                        width: 150,
                        child: Center(child: FilterBar(
                          items: ['All','You Owe','You are owed'], hintText: 'Balance Type'
                          , index: 1,

                        ))),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 100,
                        width: 150,
                        child: Center(child: FilterBar(
                          items: ['All','Food','Shopping','Travel','Movies','Others','settle'], hintText: 'Expense Type'
                          ,index: 0,

                        ))),
                  ),
                ),
                
            ]),
            FutureBuilder(
                future: FireStrMtd().getActivity(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  return Observer(
                    builder: (context) {

                      List<ExpenseModel> lt = filterFunction(input: snapshot.data!, type: commonStore.type, type2: commonStore.type2);
                      return Column(
                        children: [
                          for (ExpenseModel e in lt.reversed)
                            ActivityTile(expmodel: e)
                        ],
                      );
                    }
                  );
                })
          ],
        ),
      ),
    );
  }
}
