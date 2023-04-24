import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../widgets/fields/authentication/auth_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String _errorMessage = "";


  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
          body: Center(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {

                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 67,
                        ),
                        Text(
                          "Sign Up",
                          style: GoogleFonts.poppins(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: HexColor("#4f4f4f"),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "User Type",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: HexColor("#8d8d8d"),
                            ),
                          ),
                          // DropdownButton<String>(
                          //   value: dropdownValue,
                          //   icon: const Icon(Icons.arrow_drop_down),
                          //   elevation: 16,
                          //   style: GoogleFonts.poppins(
                          //     fontSize: 15,
                          //     color: HexColor("#8d8d8d"),
                          //   ),
                          //   isExpanded: true,
                          //   underline: Container(
                          //     height: 2,
                          //     color: HexColor("#ffffff"),
                          //   ),
                          //   iconSize: 30,
                          //   borderRadius: BorderRadius.circular(20),
                          //   onChanged: (String? value) {
                          //     setState(() {
                          //       dropdownValue = value!;
                          //       signUpController.setUserType(value);
                          //     });
                          //   },
                          //   items: list.map<DropdownMenuItem<String>>((String value) {
                          //     return DropdownMenuItem<String>(
                          //       value: value,
                          //       child: Text(value),
                          //     );
                          //   }).toList(),
                          // ),
                          const SizedBox(
                            height: 1,
                          ),
                          Text(
                            "Email",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: HexColor("#8d8d8d"),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            controller: emailController,
                            onChanged: (value) {
                              // validateEmail(value);
                              // signUpController.setEmail(value);
                            },
                            onSubmitted: (value) {
                              // signUpController.setEmail(value);
                            },
                            cursorColor: HexColor("#4f4f4f"),
                            decoration: InputDecoration(
                              hintText: "hello@gmail.com",
                              fillColor: HexColor("#f0f3f1"),
                              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 15,
                                color: HexColor("#8d8d8d"),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: Text(
                              _errorMessage,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Password",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: HexColor("#8d8d8d"),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextField(
                            onChanged: (value) {
                              // signUpController.setPassword(value);
                            },
                            onSubmitted: (value) {
                              // signUpController.setPassword(value);
                            },
                            obscureText: true,
                            controller: passwordController,
                            cursorColor: HexColor("#4f4f4f"),
                            decoration: InputDecoration(
                              hintText: "*************",
                              fillColor: HexColor("#f0f3f1"),
                              contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 15,
                                color: HexColor("#8d8d8d"),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              focusColor: HexColor("#44564a"),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          MyButton(
                              buttonText: 'Proceed',
                              onPressed: () async {
                                // if (signUpController.userType != null &&
                                //     signUpController.email != null &&
                                //     signUpController.password != null) {
                                //   bool isRegistered =
                                //   await signUpController.registerUser(
                                //       signUpController.email.toString(),
                                //       signUpController.password.toString());
                                //   debugPrint(isRegistered.toString());
                                //   if (isRegistered) {
                                //     Get.snackbar("Success", "User Registered");
                                //     flowController.setFlow(2);
                                //   } else {
                                //     Get.snackbar("Error", "Please fill all the fields");
                                //   }
                                // }
                              }
                              ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                            child: Row(
                              children: [
                                Text("Already have an account?",
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: HexColor("#8d8d8d"),
                                    )),
                                TextButton(
                                  child: Text(
                                    "Log In",
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: HexColor("#44564a"),
                                    ),
                                  ),
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Scaffold(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ),
        ));
  }
}
