import 'package:flutter/material.dart';
import 'package:splitwise/screens/authentication/login.dart';
import 'package:splitwise/screens/authentication/signup.dart';
import '../../constants/colors.dart';

class FirstPage extends StatelessWidget {
  static const String id = '/first';
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/Images/logo.png'),
              ElevatedButton(
                onPressed: (){Navigator.pushNamed(context, LoginPage.id);},
                style: ElevatedButton.styleFrom(minimumSize: const Size(320,0), padding: const EdgeInsets.all(10), backgroundColor: kgreen),
                child: const Text('Log in'),
              ),
              OutlinedButton(
                onPressed: (){Navigator.pushNamed(context, SignInPage.id);},
                style: OutlinedButton.styleFrom(
                    foregroundColor: kgreen, minimumSize: const Size(320,0),
                    padding: const EdgeInsets.all(10),
                    side: const BorderSide(color: kgreen,)),
                child: const Text('Sign up'),
              )
            ],
          ),
        ),
      ),
    );
  }
}