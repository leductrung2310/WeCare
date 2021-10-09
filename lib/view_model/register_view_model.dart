import 'package:flutter/cupertino.dart';

class RegisterViewModel extends ChangeNotifier {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

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

  bool _isVisible = false;
  get isVisible => _isVisible;

  set isVisible(value) {
    _isVisible = value;
    notifyListeners();
  }

  bool _isConfirmVisible = false;
  get isConfirmVisible => _isConfirmVisible;

  set isConfirmVisible(value) {
    _isConfirmVisible = value;
    notifyListeners();
  }

  int _gender = 0;
  get Gender => _gender;

  set Gender(value) {
    _gender = value;
    notifyListeners();
  }

  String? passwordValidator(text) {
    if (text.toString().length < 6 || text == "") {
      return 'Password không hợp lệ';
    }
    return null;
  }

  String? passwordRepeatValidator(text) {
    if (text == "") return 'Password không hợp lệ';
    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      return 'Password không trùng khớp';
    }
    return null;
  }

  String? emailValidator(text) {
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(text) ||
        text == "") return 'Email không hợp lệ';
    return null;
  }

  String? nameValidator(text) {
    if (text == "") return 'Tên không hợp lệ';
    return null;
  }

  bool onNextClick() {
    if (emailController.text.isNotEmpty) return true;
    if (emailValidator(emailController.text) == "") {
      return true;
    }
    return false;
  }
}
