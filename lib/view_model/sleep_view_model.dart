import 'package:flutter/material.dart';

class SleepViewModel extends ChangeNotifier {
  String _dropdownHourValue = "7";
  String _dropdownMinuteValue = "23";
  String _dropdownValue = "AM";
  bool _selected = false;
  double _averageSleep = 0.0;

  set dropdownHourValue(String? newValue) {
    _dropdownHourValue = newValue!;
    notifyListeners();
  }

  String get dropdownHourValue => _dropdownHourValue;

  set dropdownMinuteValue(String? newValue) {
    _dropdownMinuteValue = newValue!;
    notifyListeners();
  }

  String get dropdownMinuteValue => _dropdownMinuteValue;

  set dropdownValue(String? newValue) {
    _dropdownValue = newValue!;
    notifyListeners();
  }

  String get dropdownValue => _dropdownValue;

  set selected(newValue) {
    _selected = newValue;
    notifyListeners();
  }

  get selected => _selected;

  set averageSleep(newValue) {
    _averageSleep = newValue;
    notifyListeners();
  }

  double get averageSleep => _averageSleep;
}
