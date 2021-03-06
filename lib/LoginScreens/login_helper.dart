import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginHelper {
  static UserCredential userCredential1;
  static signInWithGoogle() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential cred =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (cred != null) {
      sharedPreferences.setString("token", "value");
      sharedPreferences.setString(
          "name",
          // cred.additionalUserInfo.profile["name"]
          "Null");
      sharedPreferences.setString(
          "email", cred.additionalUserInfo.profile["email"]);
      if (cred.additionalUserInfo.isNewUser == true) {
        print(cred.additionalUserInfo);
        return true;
      } else {
        print(cred.additionalUserInfo);

        return false;
      }
    }
    // print();

    // CollectionReference users = FirebaseFirestore.instance
    //     .collection();
  }

  static signInwithEmail(String email, String pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      userCredential1 = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      sharedPreferences.setString("email", email);
      sharedPreferences.setString("token", "value");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return ('Wrong password provided for that user.');
      }
    }
  }
}

class SignUphelper {
  static signUpUsingEmail(String email, String pass, String name) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pass);
      print(email + pass);
      sharedPreferences.setString("token", "value");
      sharedPreferences.setString(
          "name",
          // cred.additionalUserInfo.profile["name"]
          name);
      sharedPreferences.setString("email", email);
      return userCredential.user.email;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
