import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/model/exercise/history_workouts_day.dart';
import 'package:wecare_flutter/model/exercise/total_weekly_history.dart';
import 'package:wecare_flutter/model/exercise/total_workout.dart';
import 'package:wecare_flutter/view_model/exercise/exercise_view_model.dart';
import 'package:wecare_flutter/view_model/home_vm/weekly_calendar_viewmodel.dart';

class HistoryWorkoutViewModel extends ChangeNotifier {
  TotalWorkouts totalWorkoutsFromDB = TotalWorkouts();
  TotalWeekly totalWeekly = TotalWeekly();

  int _totalWorkouts = 0;
  int _totalMinutes = 0;
  double _totalKcal = 0;

  String _week = "";
  int _totalWeeklyWorkouts = 0;
  int _totalWeeklyMinutes = 0;
  double _totalWeeklyKcal = 0;

  List<HistoryWorkoutDay> _listHistory = [];
  List<Day> _listDay = [];

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

  String get week => _week;
  set week(newVal) {
    _week = newVal;
    notifyListeners();
  }

  int get totalWeeklyWorkouts => _totalWeeklyWorkouts;
  set totalWeeklyWorkouts(newVal) {
    _totalWeeklyWorkouts = newVal;
    notifyListeners();
  }

  int get totalWeeklyMinutes => _totalWeeklyMinutes;
  set totalWeeklyMinutes(newVal) {
    _totalWeeklyMinutes = newVal;
    notifyListeners();
  }

  double get totalWeeklyKcal => _totalWeeklyKcal;
  set totalWeeklyKcal(newVal) {
    _totalWeeklyKcal = newVal;
    notifyListeners();
  }

  List<HistoryWorkoutDay> get listHistory => _listHistory;
  set listHistory(newVal) {
    _listHistory = [];
    notifyListeners();
  }

  List<Day> get listDay => _listDay;
  set listDay(newVal) {
    _listDay = [];
    notifyListeners();
  }

  String getDay(int x) {
    DateTime currentTime = DateTime.now();
    int day = currentTime.subtract(Duration(days: currentTime.weekday - x)).day;
    int month =
        currentTime.subtract(Duration(days: currentTime.weekday - x)).month;
    return "$day-$month";
  }

  String getCurrentDay() {
    DateTime now = DateTime.now();
    return "${now.day}-${now.month}";
  }

  void plusTotalWeekly(
      BuildContext context, int workouts, int minutes, double kcal) {
    final weeklyCalendar =
        Provider.of<WeeklyCalendarVM>(context, listen: false);

    String formattedStartOfWeek =
        DateFormat.MMMd().format(weeklyCalendar.getStartOfWeek);
    String formattedEndOfWeek =
        DateFormat.MMMd().format(weeklyCalendar.getEndOfWeek);

    String week = "$formattedStartOfWeek-$formattedEndOfWeek";

    _week = week;
    _totalWeeklyWorkouts += workouts;
    _totalWeeklyMinutes += minutes;
    _totalWeeklyKcal += kcal;
    notifyListeners();
  }

  bool checkWorkouted(int day) {
    for (var i in listDay) {
      if (i.day == day) {
        return true;
      }
    }
    return false;
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
    week = "";
    totalWeeklyKcal = 0.0;
    totalWeeklyMinutes = 0;
    totalWeeklyWorkouts = 0;
    listHistory = [];
    listDay = [];
  }

  String getSubDocument(BuildContext context) {
    final weeklyCalendar =
        Provider.of<WeeklyCalendarVM>(context, listen: false);

    String formattedStartOfWeek =
        DateFormat('ddMMyy').format(weeklyCalendar.getStartOfWeek);
    String formattedEndOfWeek =
        DateFormat('ddMMyy').format(weeklyCalendar.getEndOfWeek);

    return "$formattedStartOfWeek-$formattedEndOfWeek";
  }

  Future pushHistoryToFireStore(BuildContext context) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final workoutViewModel =
        Provider.of<WorkoutViewModel>(context, listen: false);
    User? user = FirebaseAuth.instance.currentUser;
    HistoryWorkoutDay historyWorkoutDay = HistoryWorkoutDay();

    DateTime now = DateTime.now();
    String formattedNow = DateFormat('dd-MM-yyyy-hh:mm:ss').format(now);

    String subDocument = getSubDocument(context);

    historyWorkoutDay.time = DateTime.now();
    historyWorkoutDay.minutes = workoutViewModel.countWorkoutTime;
    historyWorkoutDay.kcal = workoutViewModel.countWorkoutTime * 0.308;
    historyWorkoutDay.workouts =
        workoutViewModel.listExercise[workoutViewModel.indexWorkout + 1].name;

    await firebaseFirestore
        .collection("workoutsHistory")
        .doc(user?.uid)
        .collection("list")
        .doc(subDocument)
        .collection("${now.day}-${now.month}")
        .doc(formattedNow)
        .set(historyWorkoutDay.toJson());
  }

  Future<void> getHistoryWorkoutsFromFirebase(BuildContext context) async {
    String subDocument = getSubDocument(context);

    for (int i = 1; i < 8; i++) {
      FirebaseFirestore.instance
          .collection("workoutsHistory")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("list")
          .doc(subDocument)
          .collection(getDay(i))
          .get()
          .then(
        (value) {
          var docSnapshots = value.docs;
          for (var i in docSnapshots) {
            var doc = i.data();
            listHistory.add(HistoryWorkoutDay.fromMap(doc));
          }
        },
      );
    }
  }

  Future pushTotalWeeklyHistoryToFirestore(BuildContext context) async {
    FirebaseFirestore firebasefirestore = FirebaseFirestore.instance;

    String subDocument = getSubDocument(context);

    totalWeekly.week = _week;
    totalWeekly.totalWorkouts = _totalWeeklyWorkouts;
    totalWeekly.totalMinutes = _totalWeeklyMinutes;
    totalWeekly.totalKcal = _totalWeeklyKcal;

    await firebasefirestore
        .collection("workoutsHistory")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("list")
        .doc(subDocument)
        .set(totalWeekly.toMap());
  }

  Future<void> getTotalWeeklyHistoryToFirestore(BuildContext context) async {
    FirebaseFirestore firebasefirestore = FirebaseFirestore.instance;

    String subDocument = getSubDocument(context);

    await firebasefirestore
        .collection("workoutsHistory")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("list")
        .doc(subDocument)
        .get()
        .then((value) {
      totalWeekly = TotalWeekly.fromMap(value.data());
    });

    week = totalWeekly.week;
    totalWeeklyWorkouts = totalWeekly.totalWorkouts;
    totalWeeklyMinutes = totalWeekly.totalMinutes;
    totalWeeklyKcal = totalWeekly.totalKcal;
  }

  Future getWeekGoal(BuildContext context) async {
    String subDocument = getSubDocument(context);

    await FirebaseFirestore.instance
        .collection('weekgoal')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection(subDocument)
        .get()
        .then((value) {
      var docSnapshots = value.docs;
      for (var i in docSnapshots) {
        var doc = i.data();
        listDay.add(Day.fromMap(doc));
      }
    });


  }

  Future pushWeekGoal(BuildContext context) async {
    String subDocument = getSubDocument(context);
    Day day = Day();

    day.day = DateTime.now().day;

    await FirebaseFirestore.instance
        .collection('weekgoal')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection(subDocument)
    .doc(getCurrentDay())
    .set(day.toJson());
  }
}
