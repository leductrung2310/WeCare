import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wecare_flutter/screen/authentication/login/login_screen.dart';
import 'package:wecare_flutter/screen/main_screen.dart';
import 'package:wecare_flutter/services/authentic_service.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSingIn = GoogleSignIn();
  late bool _isSigningIn;
  final authService = AuthenticService();

  GoogleSignInProvider() {
    _isSigningIn = false;
  }

  bool get isSigningIn => _isSigningIn;

  set isSigningIn(bool newVal) {
    _isSigningIn = newVal;
    notifyListeners();
  }

  Future logInWithGoogle(BuildContext context) async {
    try {
      isSigningIn = true;

      final user = await googleSingIn.signIn();
      if (user == null) {
        isSigningIn = false;
        notifyListeners();
        return;
      } else {
        final googleAuth = await user.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Log in successfully"),
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const MainScreen()))
                })
            .catchError((e) {
          Fluttertoast.showToast(msg: e);
        });
        isSigningIn = false;
        notifyListeners();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void logOutGoogle(BuildContext context) async {
    await googleSingIn.disconnect();
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
