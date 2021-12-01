import 'dart:async';

import 'package:flutter/material.dart';

class WorkoutViewModel extends ChangeNotifier {
  int _indexWorkout = 0;
  late int _restTime;
  int _countWorkoutTime = 0;
  late Timer _timer;

  /////////////// index workout
  void setIndexWorkout() {
    Future.delayed(const Duration(milliseconds: 500), () => _indexWorkout++);
    notifyListeners();
  }

  void setPreviousIndexWorkout() {
    if (_indexWorkout == 0) {
    } else {
      _indexWorkout--;
    }
    notifyListeners();
  }

  set indexWorkout(newValue) {
    _indexWorkout = newValue;
    notifyListeners();
  }

  get indexWorkout => _indexWorkout;

  int get restTime => _restTime;

  ////////////////////// Count workout time
  void startTime() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _countWorkoutTime++;
    });
  }

  Timer get getTimer => _timer;

  set countWorkoutTime(newValue) {
    Future.delayed(
        const Duration(microseconds: 1000), () => _countWorkoutTime = newValue);
    notifyListeners();
  }

  get countWorkoutTime => _countWorkoutTime;

  String formatWorkoutTime() {
    int _minute = _countWorkoutTime ~/ 60;
    int _second = _countWorkoutTime - (_minute * 60);

    if (_minute < 10) {
      if (_second < 10) {
        return "0$_minute:0$_second";
      } else {
        return "0$_minute:$_second";
      }
    } else if (_second < 10) {
      return "$_minute:0$_second";
    }

    return "$_minute:$_second";
  }

  void reset() {
    indexWorkout = 0;
    countWorkoutTime = 0;
  }
}
