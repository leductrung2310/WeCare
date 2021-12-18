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

  DateTime _suggestedSleepTime1 = DateTime(2021, 1, 1, 0, 0);
  DateTime _suggestedSleepTime2 = DateTime(2021, 1, 1, 0, 0);
  DateTime _suggestedSleepTime3 = DateTime(2021, 1, 1, 0, 0);

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
    _suggestedSleepTime1 = _wakeupTime.subtract(Duration(
      hours: secondCycle.hour,
      minutes: firstCycle.minute,
    ));

    _suggestedSleepTime2 = _wakeupTime.subtract(Duration(
      hours: firstCycle.hour,
      minutes: secondCycle.minute,
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
    DateTime sleepTime = Provider.of<AuthenticService>(context, listen: false)
            .loggedInUser
            .sleepTime ??
        DateTime.now();
    DateTime now = DateTime.now();

    if (_isFirstSleepSuggestedClick) {
      sleepTime = _suggestedSleepTime1;
    }
    if (_isSecondSleepSuggestedClick) {
      sleepTime = _suggestedSleepTime2;
    }
    if (_isThirdSleepSuggestedClick) {
      sleepTime = _suggestedSleepTime3;
    }

    duration = Duration(
      hours: (sleepTime.hour == 0 ? 24 : sleepTime.hour) -
                  (now.hour == 0 ? 24 : now.hour) <
              0
          ? now.hour - sleepTime.hour
          : sleepTime.hour - now.hour,
      minutes: sleepTime.minute - now.minute < 0
          ? now.minute - sleepTime.minute
          : sleepTime.minute - now.minute,
    );

    timer = Timer.periodic(
      duration,
      (timer) {
        //const minusSecond = 1;
        const minusMinute = 1;
        final minutes = duration.inMinutes - minusMinute;
        //final seconds = duration.inSeconds - minusSecond;
        //duration = Duration(seconds: seconds);
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
