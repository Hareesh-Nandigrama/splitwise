import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:splitwise/screens/activity.dart';
import 'package:splitwise/screens/add_expense.dart';
import 'package:splitwise/screens/groups/group_home.dart';
import 'package:splitwise/screens/profile.dart';
import 'package:splitwise/widgets/nav_bar.dart';

import '../constants/colors.dart';
import '../constants/enums.dart';
import '../stores/common_store.dart';
import 'friends/add_friend.dart';

class HomeScreen extends StatefulWidget {
  static const String id = '/home';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final tabs = {
    Pages.account: ProfilePage(),
    Pages.groups: GroupHome(),
    Pages.friends: Container(),
    Pages.activity: Container(),
  };
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();

    return SafeArea(
      child: Observer(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            leading: Container(),
            leadingWidth: 0,
            centerTitle: true,
            title: Text(
              commonStore.page == Pages.activity ? "Activity" :
              commonStore.page == Pages.account ? "Account" : ""
            ),
            actions: [
              commonStore.page == Pages.groups ? IconButton(onPressed: (){}, icon: Icon(Icons.group_add_outlined)):
              commonStore.page == Pages.friends ? IconButton(onPressed: (){
                Navigator.of(context).pushNamed(AddFriendPage.id);
              }, icon: Icon(Icons.person_add_alt_1)):Container()
            ],
          ),
          body: tabs[commonStore.page],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: commonStore.page != Pages.account && commonStore.page != Pages.activity
              ? ElevatedButton(onPressed: (){
                Navigator.of(context).pushNamed(AddExpensePage.id);
          }, child: Text('Add Expenses'))
              : Container(),
          bottomNavigationBar: const BottomNavBar(),
        );
      }),
    );
  }
}
