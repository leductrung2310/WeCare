import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/model/wecare_user.dart';
import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/screen/authentication/login/home_view_mode.dart';
import 'package:wecare_flutter/screen/authentication/register/register_update_infor_screen.dart';
import 'package:wecare_flutter/screen/main_screen.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:wecare_flutter/screen/profile/change_password_screen.dart';

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

  bool _isLoginHome = false;

  bool get isLoginHome => _isLoginHome;
  set isLoginHome(newValue) {
    _isLoginHome = newValue;
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
      _isLoginHome = true;
      _desiredAmount = ((_loggedInUser.weight ?? 10) * 0.03);
      notifyListeners();
    });
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

  void signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    isLoading = true;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) async => {whenCompleteSignIn(context)});
    } catch (e) {
      isLoading = false;
      Fluttertoast.showToast(msg: getMessageFromErrorCode(e));
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

  Future<void> signOut(BuildContext context) async {
    isLoading = false;
    loggedInUser = WeCareUser();
    await FirebaseAuth.instance.signOut();
    FacebookAuth.instance.logOut();
    resetEmailAndPasswordController(context);
    Navigator.pushReplacementNamed(context, Routes.login);
  }

  set setAvatar(value) {
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

  late AccessToken fbAccessToken;

  void signInWithFacebook(BuildContext context) async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      switch (result.status) {
        case LoginStatus.cancelled:
          break;
        case LoginStatus.failed:
          break;
        case LoginStatus.operationInProgress:
          break;
        case LoginStatus.success:
          fbAccessToken = result.accessToken!;
          var credential = FacebookAuthProvider.credential(fbAccessToken.token);
          await signInFirebase(credential, context);
          break;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: getMessageFromErrorCode(e));
    }
  }

  Future signInFirebase(AuthCredential credential, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithCredential(credential).then(
            (uid) => {
              Fluttertoast.showToast(msg: "Log in successfully"),
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const ChangePasswordScreen(),
                ),
              )
            },
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        // handle the error here
      } else if (e.code == 'invalid-credential') {
        // handle the error here
      }
    } catch (e) {
      // handle the error here
    }
  }

  double _desiredAmount = 0;
  set setDesiredAmount(newVal){
    _desiredAmount = newVal;
    notifyListeners();
  }
  get getDesiredAmount => _desiredAmount;

  double calculateDesiredAmount(BuildContext context) {
    return ((_loggedInUser.weight ?? 10) * 0.03);
  }
}
