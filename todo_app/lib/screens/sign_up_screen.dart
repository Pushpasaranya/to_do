// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/screens/LoginScreen.dart';

// ignore: must_be_immutable, camel_case_types
class sign_up_screen extends StatefulWidget {
  sign_up_screen({Key? key}) : super(key: key);

  @override
  State<sign_up_screen> createState() => _sign_up_screenState();

  bool textVisible = true;
  bool passwordVisible = true;
  bool confirmpassword = true;
}

// ignore: camel_case_types
class _sign_up_screenState extends State<sign_up_screen> {
  // ignore: non_constant_identifier_names
  final _sign_upFormkey = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController username = TextEditingController();
  TextEditingController emailaddress = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
      if (kDebugMode) {
        print("Google Sign-In Error: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _sign_upFormkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              Stack(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    radius: 54,
                    backgroundImage: AssetImage("assets/userlogin image.png"),
                  ),
                  Positioned(
                    bottom: -9,
                    left: 10,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: username,
                  validator: (username) {
                    if (username != null && username.isEmpty) {
                      return "Enter your username";
                    }

                    return null;
                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      hintText: "Enter your username",
                      labelText: "Username",
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
                    const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
                child: TextFormField(
                  controller: emailaddress,
                  validator: (emailaddress) {
                    if (emailaddress != null && emailaddress.isEmpty) {
                      if (emailaddress == null || emailaddress.isEmpty) {
                        return "Enter your email address";
                      } else if (!RegExp(
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                          .hasMatch(emailaddress)) {
                        return "Enter a valid email address";
                      }
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
                      if (password == null || password.isEmpty) {
                        return "Enter your password";
                      } else if (password.length < 6) {
                        return "Password must be at least 6 characters";
                      }
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
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10),
                child: TextFormField(
                    obscureText: passtext,
                    keyboardType: TextInputType.text,
                    maxLength: 6,
                    controller: confirmPasswordController,
                    validator: (confirmpassword) {
                      if (confirmpassword == null || confirmpassword.isEmpty) {
                        return "Enter your 6 digit password";
                      } else if (confirmpassword != password.text) {
                        return "Passwords do not match";
                      }
                      return null; // Return null when there is no error
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
                        hintText: "confirm your password",
                        labelText: " Confirm Password",
                        labelStyle: const TextStyle(color: Colors.green),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.purple),
                            borderRadius: BorderRadius.circular(20.0)),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20.0)))),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 40, right: 40, bottom: 20),
                child: SizedBox(
                  height: 40.0,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          side: const BorderSide(style: BorderStyle.solid),
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                      onPressed: () async {
                        if (_sign_upFormkey.currentState!.validate()) {
                          try {
                            // ignore: unused_local_variable
                            UserCredential userCredential =
                                await _auth.createUserWithEmailAndPassword(
                              email: emailaddress.text,
                              password: password.text,
                            );
                            // The user is registered successfully.
                            // You can do additional actions here, such as navigating to a new screen.

                            // Show a SnackBar on successful registration
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Registration successful!'),
                                duration: Duration(seconds: 3),
                                backgroundColor: Colors.deepPurple,
                              ),
                            );
                            // Clear the text fields after successful registration
                            username.clear();
                            emailaddress.clear();
                            password.clear();
                            confirmPasswordController.clear();
                            // Navigate to the next screen (optional)
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => NextScreen()),
                            // );
                          } catch (e) {
                            // Handle registration errors (e.g., email is already in use).
                            if (kDebugMode) {
                              print("Registration Error: $e");
                            }
                          }
                        }
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(fontSize: 18),
                      )),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("or"),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: _handleGoogleSignIn,
                    child: Image.asset(
                      "assets/G-sign_up image.png",
                      height: 32,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 120.0),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Already have an account?"),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                ]),
              ),
            ], // Close the children list
          ),
        ),
      ),
    );
  }
}
