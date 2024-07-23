// ignore_for_file: library_private_types_in_public_api, camel_case_types, sort_child_properties_last, avoid_unnecessary_containers

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo_app/screens/app_page.dart';
import 'package:todo_app/screens/forgot_password.dart';
import 'package:todo_app/screens/sign_up_screen.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
  bool textVisible = true;
  bool passwordVisible = true;
}

class _LoginScreenState extends State<LoginScreen> {
  final _logInFormkey = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool passtext = true;

  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // The user canceled the Google Sign-In process.
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      if (user != null) {
        // User has been signed in with Google successfully.
        // You can navigate to the next screen or perform any other actions here.
      }
    } catch (e) {
      // Handle any errors that occur during Google Sign-In.
      // ignore: avoid_print
      print("Google Sign-In Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _logInFormkey,
        child: ListView(
          children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Image.asset("assets/todo image 2.jpeg"),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
              child: TextFormField(
                controller: email,
                validator: (emailaddress) {
                  if (emailaddress != null && emailaddress.isEmpty) {
                    return "Enter your email address";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.mail,
                      color: Colors.grey,
                    ),
                    hintText: "Enter your emailaddress",
                    labelText: "Email",
                    labelStyle: const TextStyle(color: Colors.green),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.circular(20.0)),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20.0))),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10),
              child: TextFormField(
                obscureText: passtext,
                keyboardType: TextInputType.text,
                maxLength: 6,
                controller: password,
                validator: (password) {
                  if (password != null && password.isEmpty) {
                    return "Enter your 6 digit password";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passtext = !passtext;
                          });
                        },
                        icon: passtext
                            ? const Icon(
                                Icons.visibility,
                                color: Colors.grey,
                              )
                            : const Icon(
                                Icons.visibility_off,
                                color: Colors.grey,
                              )),
                    prefixIcon: const Icon(
                      Icons.password,
                      color: Colors.grey,
                    ),
                    hintText: "Enter your password",
                    labelText: "Password",
                    labelStyle: const TextStyle(color: Colors.green),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.purple),
                        borderRadius: BorderRadius.circular(20.0)),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20.0))),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const forgot_password();
                      }));
                    },
                    child: const Text("Forgot Password?"))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, left: 30, right: 30, bottom: 10),
              child: SizedBox(
                height: 40.0,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: const BorderSide(style: BorderStyle.solid),
                        backgroundColor:
                            const Color.fromARGB(255, 24, 166, 238),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                    onPressed: () {
                      if (_logInFormkey.currentState!.validate()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              // Return the widget for the new page you want to navigate to
                              return const ToDo(); // Replace YourNewPage with the actual page you want to navigate to
                            },
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 18),
                    )),
              ),
            ),
            const SizedBox(
              height: 0.5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("or"),
                const SizedBox(
                  width: double.infinity,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: _handleGoogleSignIn,
                  child: Image.asset("assets/G-sign_in image.jpg", height: 32),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                child: const Text("Don't have an account?"),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => sign_up_screen()));
                  },
                  child: Container(
                    child: const Text("Sign up",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange)),
                  )),
            ]),
          ],
        ),
      ),
    );
  }
}
