import 'package:flutter/material.dart';
import 'package:wecare_flutter/model/time_model.dart';

class SleepViewModel extends ChangeNotifier {
  String _dropdownHourValue = "7";
  String _dropdownMinuteValue = "23";
  String _dropdownValue = "AM";
  bool _selected = false;
  bool _calculateFrame = true;
  double _averageSleep = 7.7;
  int _selectedButton = 0;
  bool _alarmValue = false;
  final Time _suggestedTime1= Time(hour: 0, minute: 0, period: "AM") ;
  final Time _suggestedTime2 = Time(hour: 0, minute: 0, period: "AM") ;
  final Time _suggestedTime3 = Time(hour: 0, minute: 0, period: "AM");

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

  set selectedButton(newValue) {
    _selectedButton = newValue;
    notifyListeners();
  }

  get selectedButton => _selectedButton;

  set alarmValue(newValue) {
    _alarmValue = newValue;
    notifyListeners();
  }

  get alarmValue => _alarmValue;

  void calculateSleepTime() {

    //calculate first suggested sleep time
    _suggestedTime1.minute = int.parse(_dropdownMinuteValue) - 45;
    if(_suggestedTime1.minute < 0) {
      _suggestedTime1.minute = 60 + _suggestedTime1.minute;
      _suggestedTime1.hour = int.parse(_dropdownHourValue) - 7 - 1;
      if(_suggestedTime1.hour < 0){
        _suggestedTime1.hour = 12 + _suggestedTime1.hour ;
        if(dropdownValue == "AM") {
          _suggestedTime1.period = "PM";
        }
        else {
          _suggestedTime1.period = "AM";
        }
      } else {
        _suggestedTime1.period = _dropdownValue;
      }
    } else {
      _suggestedTime1.hour = int.parse(_dropdownHourValue) - 7;
      if(_suggestedTime1.hour < 0){
        _suggestedTime1.hour = 12 + _suggestedTime1.hour ;
        if(dropdownValue == "AM") {
          _suggestedTime1.period = "PM";
        }
        else {
          _suggestedTime1.period = "AM";
        }
      } else {
        _suggestedTime1.period = _dropdownValue;
      }
    }

    //calculate second suggested sleep time
    _suggestedTime2.minute = int.parse(_dropdownMinuteValue) - 15;
    if(_suggestedTime2.minute < 0) {
      _suggestedTime2.minute = 60 + _suggestedTime2.minute;
      _suggestedTime2.hour = int.parse(_dropdownHourValue) - 6 - 1;
      if(_suggestedTime2.hour < 0){
        _suggestedTime2.hour = 12 + _suggestedTime2.hour ;
        if(dropdownValue == "AM") {
          _suggestedTime2.period = "PM";
        }
        else {
          _suggestedTime2.period = "AM";
        }
      } else {
        _suggestedTime2.period = _dropdownValue;
      }
    } else {
      _suggestedTime2.hour = int.parse(_dropdownHourValue) - 6;
      if(_suggestedTime2.hour < 0){
        _suggestedTime2.hour = 12 + _suggestedTime2.hour ;
        if(dropdownValue == "AM") {
          _suggestedTime2.period = "PM";
        }
        else {
          _suggestedTime2.period = "AM";
        }
      } else {
        _suggestedTime2.period = _dropdownValue;
      }
    }

    //calculate third suggested sleep time
    _suggestedTime3.minute = int.parse(_dropdownMinuteValue) - 45;
    if(_suggestedTime3.minute < 0) {
      _suggestedTime3.minute = 60 + _suggestedTime3.minute;
      _suggestedTime3.hour = int.parse(_dropdownHourValue) - 4 - 1;
      if(_suggestedTime3.hour < 0){
        _suggestedTime3.hour = 12 + _suggestedTime3.hour ;
        if(dropdownValue == "AM") {
          _suggestedTime3.period = "PM";
        }
        else {
          _suggestedTime3.period = "AM";
        }
      } else {
        _suggestedTime3.period = _dropdownValue;
      }
    } else {
      _suggestedTime3.hour = int.parse(_dropdownHourValue) - 4;
      if(_suggestedTime3.hour < 0){
        _suggestedTime3.hour = 12 + _suggestedTime3.hour ;
        if(dropdownValue == "AM") {
          _suggestedTime3.period = "PM";
        }
        else {
          _suggestedTime3.period = "AM";
        }
      } else {
        _suggestedTime3.period = _dropdownValue;
      }
    }

    notifyListeners();
  }

  Time get suggestedTime1 => _suggestedTime1;
  Time get suggestedTime2 => _suggestedTime2;
  Time get suggestedTime3 => _suggestedTime3;

  set calculateFrame(newValue) {
    _calculateFrame = newValue;
    notifyListeners();
  }

  get calculateFrame => _calculateFrame;
}
