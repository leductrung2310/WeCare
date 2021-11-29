import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/model/wecare_user.dart';
import 'package:wecare_flutter/screen/authentication/login/home_view_mode.dart';
import 'package:wecare_flutter/screen/authentication/login/login_screen.dart';
import 'package:wecare_flutter/screen/authentication/register/register_update_infor_screen.dart';
import 'package:wecare_flutter/screen/main_screen.dart';

class AuthenticService extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  bool _isLoading = false;
  bool _isLogin = false;
  int loginType = 0;

  WeCareUser _loggedInUser = WeCareUser();

  WeCareUser get loggedInUser => _loggedInUser;

  bool get isLoading => _isLoading;

  set isLoading(newValue) {
    _isLoading = newValue;
    notifyListeners();
  }

  bool get isLogin => _isLogin;

  set isLogin(bool newVal) {
    _isLogin = newVal;
    notifyListeners();
  }

  void createUserWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    isLoading = true;
    await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RegisterUpdateInfoScreen())),
            })
        .catchError((e) {
      isLoading = false;
      Fluttertoast.showToast(msg: e.toString());
    });
  }

  void resetEmailAndPasswordController(BuildContext context) {
    final loginVM = Provider.of<LoginViewModel>(context, listen: false);
    loginVM.emailController.text = "";
    loginVM.passwordController.text = "";
  }

  Future<void> getDataFromFirebase() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(_firebaseAuth.currentUser?.uid)
        .get()
        .then((value) {
      _loggedInUser = WeCareUser.fromMap(value.data());
    });
  }

  void signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    isLoading = true;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) async => {await getDataFromFirebase()})
          .timeout(const Duration(seconds: 10))
          .whenComplete(() => {whenCompleteSignIn(context)});
    } catch (e) {
      isLoading = false;
      //Fluttertoast.showToast(msg:);
    }
  }

  void whenCompleteSignIn(BuildContext context) {
    isLoading = false;
    Fluttertoast.showToast(msg: "Log in successfully");
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MainScreen(),
      ),
    );
  }

  Future<void> signOutWithEmail(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    resetEmailAndPasswordController(context);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
