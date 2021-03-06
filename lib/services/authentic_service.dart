import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wecare_flutter/model/wecare_user.dart';
import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/screen/authentication/login/home_view_mode.dart';
import 'package:wecare_flutter/screen/authentication/register/register_update_infor_screen.dart';
import 'package:wecare_flutter/screen/main_screen.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthenticService extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  bool _isLoading = false;

  int _loginType = 0;

  late SharedPreferences prefs;

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

  int get loginType => _loginType;
  set loginType(newValue) {
    _loginType = newValue;
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
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? uid = prefs.getString('uid');

    if (uid == null) {
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
    } else {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .get()
          .then((value) {
        _loggedInUser = WeCareUser.fromMap(value.data());
        _isLoginHome = true;
        _desiredAmount = ((_loggedInUser.weight ?? 10) * 0.03);
        notifyListeners();
      });
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

  void signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    isLoading = true;
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) async => {
                loginType = 1,
                whenCompleteSignIn(context),
                prefs = await SharedPreferences.getInstance(),
                prefs.setString(
                    'uid', _firebaseAuth.currentUser?.uid ?? 'nulluser')
              });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        Fluttertoast.showToast(msg: 'Invalid Email');
      } else if (e.code == 'user-disabled') {
        Fluttertoast.showToast(msg: 'User Disabled');
      } else if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'User Not Found');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong Password');
      }
      isLoading = false;
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
    prefs = await SharedPreferences.getInstance();
    prefs.remove('uid');
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
            (uid) async => {
              checkExistUser(uid.user?.uid, context),
              prefs = await SharedPreferences.getInstance(),
              prefs.setString(
                  'uid', _firebaseAuth.currentUser?.uid ?? 'nulluser')
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

  double _desiredAmount = 0;
  set setDesiredAmount(newVal) {
    _desiredAmount = newVal;
    notifyListeners();
  }

  double get getDesiredAmount => _desiredAmount;

  double calculateDesiredAmount(BuildContext context) {
    return ((_loggedInUser.weight ?? 10) * 0.03);
  }

  void checkExistUser(uid, context) async {
    await FirebaseFirestore.instance.collection("users").doc(uid).get().then(
      (value) {
        loginType = 1;
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
}
