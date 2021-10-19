import 'package:flutter/cupertino.dart';

class SettingViewModel extends ChangeNotifier {
  bool _isDarkMode = false;
  get isDarkMode => _isDarkMode;

  set isDarkMode(value) {
    _isDarkMode = value;
    notifyListeners();
  }

  bool _isNotifications = false;
  get isNotifications => _isNotifications;

  set isNotifications(value) {
    _isNotifications = value;
    notifyListeners();
  }
}
