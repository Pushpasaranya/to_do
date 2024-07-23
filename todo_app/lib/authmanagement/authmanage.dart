import 'package:firebase_auth/firebase_auth.dart';

class AuthManage {
  AuthManage();

  Future<void> signUp(String userEmail, String userPassword) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      // ignore: avoid_print
      print("Registration successful");
    } catch (e) {
      // ignore: avoid_print
      print("Registration failed: $e");
      // Handle the error, e.g., show an error message to the user
      throw FirebaseAuthException(message: e.toString(), code: 'auth_error');
    }
  }
}
