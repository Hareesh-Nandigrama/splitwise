import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../constants/enums.dart';
import '../stores/common_store.dart';
import '../widgets/nav_bar.dart';
import 'activity.dart';
import 'friends/add_friend.dart';
import 'friends/friend_home.dart';
import 'groups/group_home.dart';
import 'groups/new_group.dart';
import 'profile.dart';

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
    Pages.friends: FriendHome(),
    Pages.activity: ActivityPage(),
  };
  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();

    return SafeArea(
      child: Observer(builder: (context) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: Container(),
              leadingWidth: 0,
              centerTitle: true,
              title: Text(
                commonStore.page == Pages.account ? "Account" : commonStore.page == Pages.activity ? "Activity":
                ""
              ),
              actions: [
                commonStore.page == Pages.groups ? IconButton(onPressed: (){
                  Navigator.of(context).pushNamed(NewGroupPage.id);
                }, icon: Icon(Icons.group_add)):
                commonStore.page == Pages.friends ? IconButton(onPressed: (){
                  Navigator.of(context).pushNamed(AddFriendPage.id);
                }, icon: Icon(Icons.person_add_alt_1)):Container()
              ],
            ),
            body: tabs[commonStore.page],
            bottomNavigationBar: const BottomNavBar(),
          ),
        );
      }),
    );
  }
}
