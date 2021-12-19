import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LoginViewModel extends ChangeNotifier {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var sendmailController = TextEditingController();

  bool _isVisible = false;
  get isVisible => _isVisible;

  set isVisible(value) {
    _isVisible = value;
    notifyListeners();
  }

  bool _isValidEmail = false;
  get isValid => _isValidEmail;

  void isValidEmail(String value) {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      _isValidEmail = true;
    } else {
      _isValidEmail = false;
    }
    notifyListeners();
  }

  bool _circular = false;
  get circular => _circular;

  set circular(value) {
    _circular = value;
    notifyListeners();
  }

  String? emailValidator(text) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(text)) return 'Invalid Email';
    return null;
  }

  void reset() {
    _isVisible = false;
    _isValidEmail = false;
    _circular = false;
    emailController = TextEditingController();
    passwordController = TextEditingController();
    sendmailController = TextEditingController();
  }

  bool _isLoadingSendEmail = false;
  get isLoadingSendEmail => _isLoadingSendEmail;

  set isLoadingSendEmail(value) {
    _isLoadingSendEmail = value;
    notifyListeners();
  }

  Future<String> onChangePasswordClick() async {
    _isLoadingSendEmail = true;
    String sendEmail = sendmailController.text.trim();
    if (sendEmail.isEmpty) {
      return 'Please enter information';
    }
    if (emailValidator(sendEmail) == 'Invalid Email') {
      return 'Invalid Email';
    }
    _isLoadingSendEmail = false;
    String res = await sendEmailForgotPassword(sendEmail);
    return res;
  }

  Future<String> sendEmailForgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return 'Please check your email';
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  void resetSendEmail() {
    _isLoadingSendEmail = false;
    sendmailController = TextEditingController();
  }
}
