import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/services/authentic_service.dart';

class SleepViewModel extends ChangeNotifier {
  DateTime _wakeupTime = DateTime.now();

  TimeOfDay firstCycle = const TimeOfDay(hour: 4, minute: 45);
  TimeOfDay secondCycle = const TimeOfDay(hour: 6, minute: 15);
  TimeOfDay thirdCycle = const TimeOfDay(hour: 7, minute: 45);

  set wakeupTime(newVal) {
    _wakeupTime = newVal;
    notifyListeners();
  }

  DateTime get wakeupTime => _wakeupTime;

  //! For bed time countdown
  Timer? timer;

  Duration duration = const Duration();

  //! For bed time
  bool _isBedTimeBtnClick = false;
  bool _showBestSleepTime = false;

  // ignore: prefer_final_fields
  DateTime _now = DateTime.now();

  DateTime _suggestedSleepTime1 = DateTime(0, 0, 0, 0, 0);
  DateTime _suggestedSleepTime2 = DateTime(0, 0, 0, 0, 0);
  DateTime _suggestedSleepTime3 = DateTime(0, 0, 0, 0, 0);

  DateTime get suggestedSleepTime1 => _suggestedSleepTime1;
  DateTime get suggestedSleepTime2 => _suggestedSleepTime2;
  DateTime get suggestedSleepTime3 => _suggestedSleepTime3;

  bool _isFirstSleepSuggestedClick = false;
  bool _isSecondSleepSuggestedClick = false;
  bool _isThirdSleepSuggestedClick = false;

  //! Get set for bed time
  set bedTimeBtnSelected(newValue) {
    _isBedTimeBtnClick = newValue;
    notifyListeners();
  }

  get bedTimeBtnSelected => _isBedTimeBtnClick;

  set showBestSleepTime(newValue) {
    _showBestSleepTime = newValue;
    notifyListeners();
  }

  get showBestSleepTime => _showBestSleepTime;

  set isFirstSleepSuggestedClick(newVal) {
    _isFirstSleepSuggestedClick = newVal;
    notifyListeners();
  }

  bool get isFirstSleepSuggestedClick => _isFirstSleepSuggestedClick;

  set isSecondSleepSuggestedClick(newVal) {
    _isSecondSleepSuggestedClick = newVal;
    notifyListeners();
  }

  bool get isSecondSleepSuggestedClick => _isSecondSleepSuggestedClick;

  set isThirdSleepSuggestedClick(newVal) {
    _isThirdSleepSuggestedClick = newVal;
    notifyListeners();
  }

  bool get isThirdSleepSuggestedClick => _isThirdSleepSuggestedClick;

  //! For wakeup time
  bool _isWakeupTimeBtnClick = false; //* for the calculate bed time button
  bool _showBestWakeupTime = false;

  DateTime _suggestedWakeupTime1 = DateTime(2021, 1, 1, 0, 0);
  DateTime _suggestedWakeupTime2 = DateTime(2021, 1, 1, 0, 0);
  DateTime _suggestedWakeupTime3 = DateTime(2021, 1, 1, 0, 0);

  DateTime get suggestedWakeupTime1 => _suggestedWakeupTime1;
  DateTime get suggestedWakeupTime2 => _suggestedWakeupTime2;
  DateTime get suggestedWakeupTime3 => _suggestedWakeupTime3;

  //! Get set for wakeup time
  set wakeupTimeBtnSelected(newValue) {
    _isWakeupTimeBtnClick = newValue;
    notifyListeners();
  }

  get wakeupTimeBtnSelected => _isWakeupTimeBtnClick;

  set showBestWakeupTime(newValue) {
    _showBestWakeupTime = newValue;
    notifyListeners();
  }

  get showBestWakeupTime => _showBestWakeupTime;

  //! Calculate bed time
  void calculateSleepTime() {
    _suggestedSleepTime1 = DateTime(_now.year, _now.month, _now.day);
    _suggestedSleepTime2 = DateTime(_now.year, _now.month, _now.day);
    _suggestedSleepTime3 = DateTime(_now.year, _now.month, _now.day);

    if (DateTime.now().day == _wakeupTime.day &&
        DateTime.now().hour >= _wakeupTime.hour) {
      _wakeupTime = _wakeupTime.add(const Duration(days: 1));
    }

    _suggestedSleepTime1 = _wakeupTime.subtract(Duration(
      hours: secondCycle.hour,
      minutes: secondCycle.minute,
    ));

    _suggestedSleepTime2 = _wakeupTime.subtract(Duration(
      hours: firstCycle.hour,
      minutes: firstCycle.minute,
    ));

    _suggestedSleepTime3 = _wakeupTime.subtract(Duration(
      hours: thirdCycle.hour,
      minutes: thirdCycle.minute,
    ));

    notifyListeners();
  }

  //! Calculate wakeup time
  void calculateWakeupTime() {
    _suggestedWakeupTime1 = _now.add(Duration(
      hours: secondCycle.hour,
      minutes: firstCycle.minute,
    ));

    _suggestedWakeupTime2 = _now.add(Duration(
      hours: firstCycle.hour,
      minutes: secondCycle.minute,
    ));

    _suggestedWakeupTime3 = _now.add(Duration(
      hours: thirdCycle.hour,
      minutes: thirdCycle.minute,
    ));

    notifyListeners();
  }

  void calculateRemindersLeft(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime sleepTime = Provider.of<AuthenticService>(context, listen: false)
            .loggedInUser
            .sleepTime ??
        now;

    int durationHours = 0;
    int durationMinutes = 0;

    if (_isFirstSleepSuggestedClick) {
      sleepTime = _suggestedSleepTime1;
    }
    if (_isSecondSleepSuggestedClick) {
      sleepTime = _suggestedSleepTime2;
    }
    if (_isThirdSleepSuggestedClick) {
      sleepTime = _suggestedSleepTime3;
    }

    if (sleepTime.day > DateTime.now().day) {
      durationHours = sleepTime.hour + (24 - now.hour);
    } else {
      durationHours =
          sleepTime.hour - now.hour < 0 ? 0 : sleepTime.hour - now.hour;
    }

    if (durationHours > 0) {
      if (sleepTime.minute - now.minute < 0) {
        durationMinutes = sleepTime.minute - now.minute;
      } else {
        durationMinutes = sleepTime.minute - now.minute;
      }
    } else {
      if (sleepTime.minute - now.minute < 0) {
        durationMinutes = 0;
      } else {
        durationMinutes = sleepTime.minute - now.minute;
      }
    }

    duration = Duration(
      hours: durationHours,
      minutes: durationMinutes,
    );

    timer = Timer.periodic(
      const Duration(minutes: 1),
      (_) {
        const minusMinute = 1;
        final minutes = duration.inSeconds - minusMinute;
        duration = Duration(minutes: minutes);
      },
    );
    notifyListeners();
  }

  void resetSleepInfo() {
    _showBestSleepTime = false;
    _showBestWakeupTime = false;
  }
}
