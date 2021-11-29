import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/model/wecare_user.dart';
import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/screen/authentication/login/home_view_mode.dart';
import 'package:wecare_flutter/screen/authentication/login/login_screen.dart';
import 'package:wecare_flutter/screen/authentication/register/register_update_infor_screen.dart';
import 'package:wecare_flutter/screen/main_screen.dart';
import 'package:wecare_flutter/services/google_service.dart';
import 'package:wecare_flutter/view_model/register_view_model.dart';

class AuthenticService extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  bool _isLoading = false;
  bool _isLogin = false;
  String _userEmail = "";
  String _userPassword = "";
  String _userName = "";
  int loginType = 0;

  User? user = FirebaseAuth.instance.currentUser;
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

  Stream<User?>? get users => _firebaseAuth.authStateChanges();

  void createUserWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    isLoading = true;
    await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {
              pushDetailToFireStore(context),
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RegisterUpdateInfoScreen())),
            })
        .catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
  }

  pushDetailToFireStore(BuildContext context) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _firebaseAuth.currentUser;

    final registerViewModel =
        Provider.of<RegisterViewModel>(context, listen: false);

    WeCareUser weCareUser = WeCareUser();

    weCareUser.email = user!.email;
    weCareUser.uid = user.uid;
    weCareUser.name = registerViewModel.nameController.text;
    weCareUser.age = 0;
    weCareUser.avatarUrl = user.photoURL;
    weCareUser.birthDay = DateTime(1999, 7, 7);
    weCareUser.gender = false;
    weCareUser.height = 0;
    weCareUser.weight = 0;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(weCareUser.toMap());
    isLoading = false;
    Fluttertoast.showToast(msg: "Account successfully created! Enjoy!");
  }

  void resetEmailAndPasswordController(BuildContext context) {
    final loginVM = Provider.of<LoginViewModel>(context, listen: false);
    loginVM.emailController.text = "";
    loginVM.passwordController.text = "";
  }

  Future<void> getDataFromFirebase() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      _loggedInUser = WeCareUser.fromMap(value.data());
    });
  }

  void signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    isLoading = true;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((uid) async => {
              isLoading = false,
              await getDataFromFirebase(),
              //await pushFoodHistoryToFireStore(),
              Fluttertoast.showToast(msg: "Log in successfully"),
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const MainScreen())),
            })
        .catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
      isLoading = false;
    });
  }

  Future<void> signOutWithEmail(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    resetEmailAndPasswordController(context);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
    print(user!.uid);
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
