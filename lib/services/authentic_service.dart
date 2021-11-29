import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/model/wecare_user.dart';
import 'package:wecare_flutter/screen/authentication/login/home_view_mode.dart';
import 'package:wecare_flutter/screen/authentication/login/login_screen.dart';
import 'package:wecare_flutter/screen/authentication/register/register_update_infor_screen.dart';
import 'package:wecare_flutter/screen/main_screen.dart';

class AuthenticService extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  bool _isLoading = false;

  WeCareUser _loggedInUser = WeCareUser();

  WeCareUser get loggedInUser => _loggedInUser;

  set loggedInUser(newVal) {
    _loggedInUser = newVal;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(newValue) {
    _isLoading = newValue;
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
    loginVM.emailController = TextEditingController();
    loginVM.passwordController = TextEditingController();
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

  void whenCompleteSignIn(BuildContext context) {
    isLoading = false;
    Fluttertoast.showToast(msg: "Log in successfully");
    Future.delayed(
      const Duration(seconds: 1),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      ),
    );
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
      Fluttertoast.showToast(msg: getMessageFromErrorCode(e));
      print(e);
    }
  }

  String getMessageFromErrorCode(e) {
    String message = "";
    switch (e) {
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        message = "Wrong email/password combination.";
        break;
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        message = "No user found with this email.";
        break;
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        message = "User disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        message = "Too many requests to log into this account.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        message = "Server error, please try again later.";
        break;
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        message = "Email address is invalid.";
        break;

      default:
        message = "Login failed. Please try again.";
    }
    return message;
  }

  Future<void> signOutWithEmail(BuildContext context) async {
    isLoading = false;
    loggedInUser = WeCareUser();
    await FirebaseAuth.instance.signOut();
    resetEmailAndPasswordController(context);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  void setAvatar(value) {
    _loggedInUser.avatarUrl = value;
    notifyListeners();
  }

  Future updateUserAvatar(String url) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_loggedInUser.uid)
        .update({
      'avatarUrl': url,
    });
  }

  pushFoodHistoryToFireStore() async {
    await FirebaseFirestore.instance
        .collection("foodHistory")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      '1': '',
      '2': '',
      '3': '',
      '4': '',
      '5': '',
    });
  }
}
