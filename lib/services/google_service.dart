import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wecare_flutter/screen/authentication/login/login_screen.dart';
import 'package:wecare_flutter/screen/authentication/register/register_update_infor_screen.dart';
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

        await signInFirebase(credential, context);

        isSigningIn = false;
        notifyListeners();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future signInFirebase(AuthCredential credential, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential).then(
            (uid) => {
              checkExistUser(uid.user?.uid, context),
            },
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        Fluttertoast.showToast(msg: e.code);
      } else if (e.code == 'invalid-credential') {
        Fluttertoast.showToast(msg: e.code);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void checkExistUser(uid, context) async {
    await FirebaseFirestore.instance.collection("users").doc(uid).get().then(
      (value) {
        if (value.exists) {
          Fluttertoast.showToast(msg: "Log in successfully");
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const RegisterUpdateInfoScreen(),
            ),
          );
        }
      },
    );
  }

  Future logOutGoogle(BuildContext context) async {
    await googleSingIn.disconnect();
    await FirebaseAuth.instance.signOut();
  }
}
