import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../stores/common_store.dart';
import '../constants/enums.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var commonStore = context.read<CommonStore>();
    return Observer(
      builder: (context) {
        return BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 6.0,
          child: SizedBox(
            height: 60.0,
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      onTap: (){
                        commonStore.setPage(Pages.groups);
                        },
                      child: Column(
                        children: [
                          Icon(Icons.groups, size: 30,color: commonStore.page == Pages.groups? kgreen : kgrey),
                          Text('Groups', style: TextStyle(color: commonStore.page == Pages.groups? kgreen : kgrey),)
                        ],
                      )
                  ),
                  GestureDetector(
                      onTap: (){commonStore.setPage(Pages.friends);},
                      child: Column(
                        children: [
                          Icon(Icons.person, size: 30, color: commonStore.page == Pages.friends? kgreen : kgrey),
                          Text('Friends', style: TextStyle(color: commonStore.page == Pages.friends? kgreen : kgrey),)
                        ],
                      )
                  ),
                  GestureDetector(
                    onTap: (){commonStore.setPage(Pages.activity);},
                      child: Column(
                        children: [

                          Icon(Icons.receipt, size: 30,color: commonStore.page == Pages.activity? kgreen : kgrey),
                          Text('Activity', style: TextStyle(color: commonStore.page == Pages.activity? kgreen : kgrey),)],
                      )
                  ),
                  GestureDetector(
                      onTap: (){commonStore.setPage(Pages.account);},
                      child: Column(
                        children: [
                          Icon(Icons.account_circle_sharp, size: 30,color: commonStore.page == Pages.account? kgreen : kgrey),
                          Text('Account', style: TextStyle(color: commonStore.page == Pages.account? kgreen : kgrey),)],
                      )
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}