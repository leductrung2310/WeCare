import 'package:flutter/material.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  var oldPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  bool _isVisible = false;
  get isVisible => _isVisible;

  set isVisible(value) {
    _isVisible = value;
    notifyListeners();
  }

  bool _isVisibleOne = false;
  get isVisibleOne => _isVisibleOne;

  set isVisibleOne(value) {
    _isVisibleOne = value;
    notifyListeners();
  }

  bool _isVisibleTow = false;
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
}
