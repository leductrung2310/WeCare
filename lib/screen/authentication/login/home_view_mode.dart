import 'package:flutter/cupertino.dart';

class LoginViewModel extends ChangeNotifier {
  bool _isVisible = true;
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
}
