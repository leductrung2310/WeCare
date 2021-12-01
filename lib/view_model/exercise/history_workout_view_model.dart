import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:wecare_flutter/model/exercise/total_workout.dart';
import 'package:wecare_flutter/screen/fitness/widget/total_history.dart';

class HistoryWorkoutViewModel extends ChangeNotifier {
  TotalWorkouts totalWorkoutsFromDB = TotalWorkouts();

  int _totalWorkouts = 0;
  int _totalMinutes = 0;
  double _totalKcal = 0;

  int get totalWorkouts => _totalWorkouts;
  set totalWorkouts(newVal) {
    _totalWorkouts = newVal;
    notifyListeners();
  }

  int get totalMinutes => _totalMinutes;
  set totalMinutes(newVal) {
    _totalMinutes = newVal;
    notifyListeners();
  }

  double get totalKcal => _totalKcal;
  set totalKcal(newVal) {
    _totalKcal = newVal;
    notifyListeners();
  }

  void plusTotal(int workouts, int minutes, double kcal) {
    _totalWorkouts += workouts;
    _totalMinutes += minutes;
    _totalKcal += kcal;
    notifyListeners();
  }

  String formatWorkoutTime() {
    int _minute = _totalMinutes ~/ 60;
    int _second = _totalMinutes - (_minute * 60);

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

  Future<void> pushTotalHistorytoFireStore() async {
    FirebaseFirestore firebasefirestor = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    totalWorkoutsFromDB.totalWorkouts = _totalWorkouts;
    totalWorkoutsFromDB.totalMinutes = _totalMinutes;
    totalWorkoutsFromDB.totalKcal = _totalKcal;

    await firebasefirestor
        .collection("totalWorkouts")
        .doc(user!.uid)
        .set(totalWorkoutsFromDB.toMap());
  }

  Future<void> getTotalWorkoutFromFirebase() async {
    FirebaseFirestore firebasefirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    await firebasefirestore
        .collection("totalWorkouts")
        .doc(user?.uid)
        .get()
        .then((value) {
      totalWorkoutsFromDB = TotalWorkouts.fromMap(value.data());
    });

    totalWorkouts = totalWorkoutsFromDB.totalWorkouts;
    totalMinutes = totalWorkoutsFromDB.totalMinutes;
    totalKcal = totalWorkoutsFromDB.totalKcal;
  }

  reset() {
    totalWorkouts = 0;
    totalMinutes = 0;
    totalKcal = 0.0;
  }

  Future pushHistoryToFireStore() async {}
}
