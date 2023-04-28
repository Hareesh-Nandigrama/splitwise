import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../firebase/auth.dart';
import '../../firebase/firestore.dart';
import '../../functions/pop_up.dart';
import '../../widgets/fields/fields.dart';
import '../home.dart';
import 'signup.dart';
import 'welcome.dart';

class LoginPage extends StatefulWidget {
  static const String id = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              alignment: AlignmentDirectional.centerStart,
              child: IconButton(
                icon: const Icon(
                  Icons.chevron_left,
                  size: 50,
                ),
                onPressed: (){Navigator.pushReplacementNamed(context, FirstPage.id);},
              ),
            ),
            Expanded(child: Container()),
            Container(
                alignment: AlignmentDirectional.center,
                height: 200,
                child: Image.asset('assets/Images/logo.png')
            ),

            InField('Email', false, _emailController, 1,0),
            InField('Password', true, _passwordController, 2,0),
            Container(
              alignment: AlignmentDirectional.centerEnd,
              padding: const EdgeInsets.fromLTRB(0,10,25,10),
              child: const Text('Forgot password?',
                style: TextStyle(
                  fontSize: 15,
                  color: kgreen,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {isLoading = true;});
                String reply = await AuthMtds().loguser(email: _emailController.text, password: _passwordController.text);
                setState(() {isLoading = false;});
                if(reply == 'Success')
                {
                  print('success');
                  await FireStrMtd().saveUserData();
                  Navigator.of(context).pushReplacementNamed(HomeScreen.id);
                }
                else
                {
                  print(reply);
                  popUp(reply, context, 1, 500, Colors.redAccent);
                }

              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(340,50),
                  padding: const EdgeInsets.all(10),
                backgroundColor: kgreen
              ),
              child: isLoading? const CircularProgressIndicator(color: Colors.white,) : const Text('Log in'),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: const Text('Or'),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  TextButton(
                    child: const Text('Sign Up', style: TextStyle(color: kgreen),),
                    onPressed: (){Navigator.pushReplacementNamed(context, SignInPage.id);},
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
          ],

        ),
      ),
    );
  }
}
