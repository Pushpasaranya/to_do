// ignore_for_file: camel_case_types, sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:todo_app/screens/LoginScreen.dart';

class forgot_password extends StatefulWidget {
  const forgot_password({super.key});

  @override
  State<forgot_password> createState() => _forgot_passwordState();
}

class _forgot_passwordState extends State<forgot_password> {
  TextEditingController resetpassword = TextEditingController();
  final resetpasswordkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Form(
        key: resetpasswordkey,
        child: ListView(
          children: [
            SizedBox(
              height: 200,
              child: Image.asset("assets/forgot_image.png"),
            ),
            const Text(
              "Enter the email address which is linked with your account.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Receive an email to reset your password",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey, fontSize: 20.0, wordSpacing: 3.0),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: resetpassword,
                validator: (email) {
                  if (email != null && email.isEmpty) {
                    return "Enter your email address";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person,
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
              padding: const EdgeInsets.only(
                  top: 20, left: 30, right: 30, bottom: 10),
              child: SizedBox(
                height: 50.0,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        side: const BorderSide(style: BorderStyle.solid),
                        backgroundColor:
                            const Color.fromARGB(255, 24, 166, 238),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                    onPressed: () async {
                      if (resetpasswordkey.currentState!.validate()) {
                        try {
                          await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: resetpassword.text,
                          );
                          // Show a SnackBar when the email is sent successfully
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Password reset email sent successfully!',
                                style: TextStyle(fontSize: 16),
                              ),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 3),
                            ),
                          );

                          // Close the screen after a delay (optional)
                          Future.delayed(const Duration(seconds: 3), () {
                            Navigator.of(context).pop();
                          });
                        } catch (e) {
                          if (kDebugMode) {
                            print("Error sending password reset email: $e");
                          }
                          // Handle the error as needed, e.g., show an error message to the user.
                        }
                      }
                    },
                    child: const Text(
                      'SEND',
                      style: TextStyle(fontSize: 18),
                    )),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                child: const Text("Remember your password?"),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                  },
                  // ignore: avoid_unnecessary_containers
                  child: Container(
                    child: const Text(" Login",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange)),
                  )),
            ]),
          ],
        ),
      )),
    );
  }
}
