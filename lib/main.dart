import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splitwise/constants/colors.dart';
import 'package:splitwise/firebase/local_storage.dart';
import 'package:splitwise/screens/add_expense.dart';
import 'package:splitwise/screens/authentication/login.dart';
import 'package:splitwise/screens/authentication/signup.dart';
import 'package:splitwise/screens/authentication/welcome.dart';
import 'package:splitwise/screens/friends/add_friend.dart';
import 'package:splitwise/screens/groups/group_home.dart';
import 'package:splitwise/screens/groups/new_group.dart';
import 'package:splitwise/screens/home.dart';
import 'package:splitwise/stores/common_store.dart';
import 'package:splitwise/stores/user_store.dart';
import 'firebase/auth.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CommonStore>(
          create: (_) => CommonStore(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Splitwise',
        theme: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: kgreen,
              ),
        ),
        home: StreamBuilder(
          stream: AuthMtds().inst().authStateChanges(),
          builder: (context, snapshot) {
            //If User Signed In
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return FutureBuilder(
                    future: LocalStorage.instance.getRecord('userdata'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var resp = snapshot.data! as Map<String, dynamic>;
                        UserStore.email = resp['email'];
                        UserStore.username = resp['username'];
                        UserStore.phoneNumber = resp['phoneNumber'];
                        List<String> t1 = [];
                        resp['friends'].forEach((element) {
                          t1.add(element as String);
                        });
                        List<String> t2 = [];
                        resp['groups'].forEach((element) {
                          t2.add(element as String);
                        });
                        UserStore.friends = t1;
                        UserStore.groups = t2;
                        return const HomeScreen();
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.grey,
                          ),
                        );
                      }
                    });
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            //Establishing Connection With Firebase
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              );
            }

            //If user Not Signed In
            return const FirstPage();
          },
        ),
        routes: {
          LoginPage.id: (context) => const LoginPage(),
          SignInPage.id: (context) => const SignInPage(),
          FirstPage.id: (context) => const FirstPage(),
          HomeScreen.id: (context) => const HomeScreen(),
          AddExpensePage.id: (context) => const AddExpensePage(),
          GroupHome.id: (context) => const GroupHome(),
          AddFriendPage.id: (context) => const AddFriendPage(),
          NewGroupPage.id: (context) => const NewGroupPage(),
        },
      ),
    );
  }
}
