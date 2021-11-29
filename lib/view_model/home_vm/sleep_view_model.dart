import 'package:flutter/material.dart';
import 'package:wecare_flutter/model/time_model.dart';

class SleepViewModel extends ChangeNotifier {
  String _dropdownHourValue = "7";
  String _dropdownMinuteValue = "00";
  String _dropdownValue = "AM";
  bool _isBedTimeBtnClick = false;
  bool _showBestSleepTime = false;
  double _averageSleep = 7.7;
  int _selectedSleepButton = -1;
  bool _alarmValue = false;
  final Time _suggestedSleepTime1 = Time(hour: 0, minute: 0, period: "AM");
  final Time _suggestedSleepTime2 = Time(hour: 0, minute: 0, period: "AM");
  final Time _suggestedSleepTime3 = Time(hour: 0, minute: 0, period: "AM");

  late TimeOfDay _now;
  bool _showBestWakeupTime = false;
  int _selectedWakeupBtn = 0;
  bool _isWakeupTimeBtnClick = false;
  bool _alarmWakeupTime = false;
  final Time _suggestedWakeupTime1 = Time(hour: 0, minute: 0, period: "AM");
  final Time _suggestedWakeupTime2 = Time(hour: 0, minute: 0, period: "AM");
  final Time _suggestedWakeupTime3 = Time(hour: 0, minute: 0, period: "AM");

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

  set bedTimeBtnSelected(newValue) {
    _isBedTimeBtnClick = newValue;
    notifyListeners();
  }

  get bedTimeBtnSelected => _isBedTimeBtnClick;

  set averageSleep(newValue) {
    _averageSleep = newValue;
    notifyListeners();
  }

  double get averageSleep => _averageSleep;

  set selectedSleepButton(newValue) {
    _selectedSleepButton = newValue;
    notifyListeners();
  }

  get selectedSleepButton => _selectedSleepButton;

  set alarmValue(newValue) {
    _alarmValue = newValue;
    notifyListeners();
  }

  get alarmValue => _alarmValue;

  set showBestSleepTime(newValue) {
    _showBestSleepTime = newValue;
    notifyListeners();
  }

  get showBestSleepTime => _showBestSleepTime;

  void calculateSleepTime() {
    //calculate first suggested sleep time
    _suggestedSleepTime1.minute = int.parse(_dropdownMinuteValue) - 45;
    if (_suggestedSleepTime1.minute < 0) {
      _suggestedSleepTime1.minute = 60 + _suggestedSleepTime1.minute;
      _suggestedSleepTime1.hour = int.parse(_dropdownHourValue) - 7 - 1;
      if (_suggestedSleepTime1.hour < 0) {
        _suggestedSleepTime1.hour = 12 + _suggestedSleepTime1.hour;
        if (dropdownValue == "AM") {
          _suggestedSleepTime1.period = "PM";
        } else {
          _suggestedSleepTime1.period = "AM";
        }
      } else {
        _suggestedSleepTime1.period = _dropdownValue;
      }
    } else {
      _suggestedSleepTime1.hour = int.parse(_dropdownHourValue) - 7;
      if (_suggestedSleepTime1.hour < 0) {
        _suggestedSleepTime1.hour = 12 + _suggestedSleepTime1.hour;
        if (dropdownValue == "AM") {
          _suggestedSleepTime1.period = "PM";
        } else {
          _suggestedSleepTime1.period = "AM";
        }
      } else {
        _suggestedSleepTime1.period = _dropdownValue;
      }
    }

    //calculate second suggested sleep time
    _suggestedSleepTime2.minute = int.parse(_dropdownMinuteValue) - 15;
    if (_suggestedSleepTime2.minute < 0) {
      _suggestedSleepTime2.minute = 60 + _suggestedSleepTime2.minute;
      _suggestedSleepTime2.hour = int.parse(_dropdownHourValue) - 6 - 1;
      if (_suggestedSleepTime2.hour < 0) {
        _suggestedSleepTime2.hour = 12 + _suggestedSleepTime2.hour;
        if (dropdownValue == "AM") {
          _suggestedSleepTime2.period = "PM";
        } else {
          _suggestedSleepTime2.period = "AM";
        }
      } else {
        _suggestedSleepTime2.period = _dropdownValue;
      }
    } else {
      _suggestedSleepTime2.hour = int.parse(_dropdownHourValue) - 6;
      if (_suggestedSleepTime2.hour < 0) {
        _suggestedSleepTime2.hour = 12 + _suggestedSleepTime2.hour;
        if (dropdownValue == "AM") {
          _suggestedSleepTime2.period = "PM";
        } else {
          _suggestedSleepTime2.period = "AM";
        }
      } else {
        _suggestedSleepTime2.period = _dropdownValue;
      }
    }

    //calculate third suggested sleep time
    _suggestedSleepTime3.minute = int.parse(_dropdownMinuteValue) - 45;
    if (_suggestedSleepTime3.minute < 0) {
      _suggestedSleepTime3.minute = 60 + _suggestedSleepTime3.minute;
      _suggestedSleepTime3.hour = int.parse(_dropdownHourValue) - 4 - 1;
      if (_suggestedSleepTime3.hour < 0) {
        _suggestedSleepTime3.hour = 12 + _suggestedSleepTime3.hour;
        if (dropdownValue == "AM") {
          _suggestedSleepTime3.period = "PM";
        } else {
          _suggestedSleepTime3.period = "AM";
        }
      } else {
        _suggestedSleepTime3.period = _dropdownValue;
      }
    } else {
      _suggestedSleepTime3.hour = int.parse(_dropdownHourValue) - 4;
      if (_suggestedSleepTime3.hour < 0) {
        _suggestedSleepTime3.hour = 12 + _suggestedSleepTime3.hour;
        if (dropdownValue == "AM") {
          _suggestedSleepTime3.period = "PM";
        } else {
          _suggestedSleepTime3.period = "AM";
        }
      } else {
        _suggestedSleepTime3.period = _dropdownValue;
      }
    }

    notifyListeners();
  }

  Time get suggestedSleepTime1 => _suggestedSleepTime1;
  Time get suggestedSleepTime2 => _suggestedSleepTime2;
  Time get suggestedSleepTime3 => _suggestedSleepTime3;

  //* Best wake up time
  set showBestWakeupTime(newValue) {
    _showBestWakeupTime = newValue;
    notifyListeners();
  }

  get showBestWakeupTime => _showBestWakeupTime;

  set selectedWakeupBtn(newValue) {
    _selectedWakeupBtn = newValue;
    notifyListeners();
  }

  get selectedWakeupBtn => _selectedWakeupBtn;

  set wakeupTimeBtnSelected(newValue) {
    _isWakeupTimeBtnClick = newValue;
    notifyListeners();
  }

  get wakeupTimeBtnSelected => _isWakeupTimeBtnClick;

  Time get suggestedWakeupTime1 => _suggestedWakeupTime1;
  Time get suggestedWakeupTime2 => _suggestedWakeupTime2;
  Time get suggestedWakeupTime3 => _suggestedWakeupTime3;

  set alarmWakeupTime(newValue) {
    _alarmWakeupTime = newValue;
    notifyListeners();
  }

  get alarmWakeupTime => _alarmWakeupTime;

  void calcullateBestWakeupTime() {
    _now = TimeOfDay.now();
    int nowMinute = _now.minute;
    int nowHour = _now.hourOfPeriod;
    DayPeriod nowPeriod = _now.period;

    //* Caluclate the first wakeup time
    _suggestedWakeupTime1.minute = nowMinute + 15;
    if (_suggestedWakeupTime1.minute >= 60) {
      _suggestedWakeupTime1.hour = nowHour + 1 + 6;
      _suggestedWakeupTime1.minute = _suggestedWakeupTime1.minute - 60;
    } else {
      _suggestedWakeupTime1.hour = nowHour + 6;
    }
    if (_suggestedWakeupTime1.hour > 12) {
      _suggestedWakeupTime1.hour = _suggestedWakeupTime1.hour - 12;
      if (nowPeriod == DayPeriod.am) {
        _suggestedWakeupTime1.period = 'PM';
      } else {_suggestedWakeupTime1.period = 'AM';}
    }
    if (_suggestedWakeupTime1.hour == 12 &&
        nowPeriod == DayPeriod.pm) {
      _suggestedWakeupTime1.hour = 0;
    }

    //* Caluclate the second wakeup time
    _suggestedWakeupTime2.minute = nowMinute + 15 + 30;
    if (_suggestedWakeupTime2.minute > 60) {
      _suggestedWakeupTime2.hour = nowHour + 1 + 4;
      _suggestedWakeupTime2.minute = _suggestedWakeupTime2.minute - 60;
    } else {
      _suggestedWakeupTime2.hour = nowHour + 4;
    }
    if (_suggestedWakeupTime2.hour > 12) {
      _suggestedWakeupTime2.hour = _suggestedWakeupTime2.hour - 12;
      if (nowPeriod == DayPeriod.am) {
        _suggestedWakeupTime2.period = 'PM';
      } else {_suggestedWakeupTime2.period = 'AM';}
    }
    if (_suggestedWakeupTime2.hour == 12 &&
        _suggestedWakeupTime2.period == 'PM') {
      _suggestedWakeupTime2.hour = 0;
    }

    //* Caluclate the final wakeup time
    _suggestedWakeupTime3.minute = nowMinute + 15 + 30;
    if (_suggestedWakeupTime3.minute > 60) {
      _suggestedWakeupTime3.hour = nowHour + 1 + 7;
      _suggestedWakeupTime3.minute = _suggestedWakeupTime3.minute - 60;
    } else {
      _suggestedWakeupTime3.hour = nowHour + 4;
    }
    if (_suggestedWakeupTime3.hour > 12) {
      _suggestedWakeupTime3.hour = _suggestedWakeupTime3.hour - 12;
      if (nowPeriod == DayPeriod.am) {
        _suggestedWakeupTime3.period = 'PM';
      } else {_suggestedWakeupTime3.period = 'AM';}
    }
    if (_suggestedWakeupTime3.hour == 12 &&
        _suggestedWakeupTime3.period == 'PM') {
      _suggestedWakeupTime3.hour = 0;
    }
  }
}
