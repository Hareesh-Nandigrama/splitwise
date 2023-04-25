import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/screens/activity.dart';
import 'package:splitwise/screens/add_expense.dart';
import 'package:splitwise/screens/profile.dart';
import 'package:splitwise/widgets/nav_bar.dart';

import '../constants/colors.dart';
import '../constants/enums.dart';
import '../stores/common_store.dart';

class HomeScreen extends StatefulWidget {
  static const String id = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final tabs = {
    Pages.account: ProfilePage(),
    Pages.groups: Container(),
    Pages.friends: Container(),
    Pages.activity: Container(),
  };
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();

    return SafeArea(
      child: Observer(builder: (context) {
        return Scaffold(
          body: tabs[commonStore.page],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: commonStore.page != Pages.account
              ? GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AddExpensePage.id);
                  },
                  child: Container(
                    width: 130,
                    color: kgreen,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(
                            Icons.receipt,
                            color: Colors.white,
                          ),
                          Text(
                            'Add Expense',
                            style: TextStyle(color: Colors.white),
                          )
                        ]),
                  ),
                )
              : Container(),
          bottomNavigationBar: const InstaBar(),
        );
      }),
    );
  }
}
