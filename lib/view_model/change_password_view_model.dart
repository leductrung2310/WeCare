import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants/constants.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  bool _isVisible = true;
  get isVisible => _isVisible;

  set isVisible(value) {
    _isVisible = value;
    notifyListeners();
  }

  bool _isVisibleOne = true;
  get isVisibleOne => _isVisibleOne;

  set isVisibleOne(value) {
    _isVisibleOne = value;
    notifyListeners();
  }

  bool _isVisibleTow = true;
  get isVisibleTow => _isVisibleTow;

  set isVisibleTow(value) {
    _isVisibleTow = value;
    notifyListeners();
  }

  String? passwordValidator(text) {
    if (text.toString().length < 6 || text == "") {
      return 'Invalid Password';
    }
    return null;
  }

  bool checkInformationEmpty() {
    if (oldPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<String> onChangePasswordClick() async {
    isLoading = true;
    String oldPass = oldPasswordController.text.trim();
    String newPass = newPasswordController.text.trim();
    String confirmPass = confirmPasswordController.text.trim();
    if (oldPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
      return 'Please enter full information';
    }
    if (!kPasswordRegex.hasMatch(newPass)) return "Invaild new password";
    if (newPass != confirmPass) return "New pasword does not match";
    if (newPass == oldPass) return "New password be the same as od password";
    String res = await changePassword(newPass, oldPass);
    isLoading = false;
    return res;
  }

  Future<String> changePassword(String newPass, String oldPass) async {
    final _firebaseAuth = FirebaseAuth.instance;
    AuthCredential credential = EmailAuthProvider.credential(
        email: _firebaseAuth.currentUser!.email!, password: oldPass);
    try {
      await _firebaseAuth.currentUser!.reauthenticateWithCredential(credential);
      await _firebaseAuth.currentUser!.updatePassword(newPass);
      return '';
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "wrong-password":
          return "Wrong password";
        default:
          return e.code;
      }
    }
  }

  void reset() {
    _isVisible = true;
    _isVisibleOne = true;
    _isVisibleTow = true;
    _isLoading = false;
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }
}
