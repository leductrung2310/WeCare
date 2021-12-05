import 'package:flutter/cupertino.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  bool _isVisibleCurrentPassword = false;
  bool get isVisibleCurrentPassword => _isVisibleCurrentPassword;

  set isVisibleCurrentPassword(newValue) {
    _isVisibleCurrentPassword = newValue;
    notifyListeners();
  }

  bool _isVisibleNewPassword = false;
  bool get isVisibleNewPassword => _isVisibleNewPassword;

  set isVisibleNewPassword(newValue) {
    _isVisibleNewPassword = newValue;
    notifyListeners();
  }

  bool _isVisibleConfirmPassword = false;
  bool get isVisibleConfirmPassword => _isVisibleConfirmPassword;

  set isVisibleConfirmPassword(newValue) {
    _isVisibleConfirmPassword = newValue;
    notifyListeners();
  }
}
