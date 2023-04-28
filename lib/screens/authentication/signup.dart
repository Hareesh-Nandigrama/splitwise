import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../firebase/auth.dart';
import '../../firebase/firestore.dart';
import '../../functions/pop_up.dart';
import '../../widgets/fields/fields.dart';
import '../home.dart';
import 'login.dart';
import 'welcome.dart';


class SignInPage extends StatefulWidget {
  static const String id = '/signin';
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
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
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
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
            InField('Username', false, _userController, 3,0),

            ElevatedButton(
              onPressed: () async {
                setState(() {isLoading = true;});
                String reply = await AuthMtds().createUser(email: _emailController.text, password: _passwordController.text, username: _userController.text, phoneNumber: '12345');
                setState(() {isLoading = false;});

                if(reply == 'Success')
                {
                  print('success');
                  FireStrMtd().saveUserData();
                  Navigator.of(context).pushReplacementNamed(HomeScreen.id);
                }
                else
                {
                  popUp(reply, context, 1, 500, Colors.red);
                }
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(340,50),
                  padding: const EdgeInsets.all(10),
                backgroundColor: kgreen
              ),
              child: isLoading? const CircularProgressIndicator(color: Colors.white,) : const Text('Sign up'),
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
                  const Text('Have an account?'),
                  TextButton(
                    child: const Text('Log in', style: TextStyle(color: kgreen),),
                    onPressed: (){Navigator.pushReplacementNamed(context, LoginPage.id);},
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



