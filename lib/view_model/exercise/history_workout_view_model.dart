import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/model/exercise/history_workouts_day.dart';
import 'package:wecare_flutter/model/exercise/total_weekly_history.dart';
import 'package:wecare_flutter/model/exercise/total_workout.dart';
import 'package:wecare_flutter/services/authentic_service.dart';
import 'package:wecare_flutter/view_model/exercise/exercise_view_model.dart';
import 'package:wecare_flutter/view_model/home_vm/weekly_calendar_viewmodel.dart';

class HistoryWorkoutViewModel extends ChangeNotifier {
  TotalWorkouts totalWorkoutsFromDB = TotalWorkouts();
  TotalWeekly totalWeekly =
      TotalWeekly(week: "", totalKcal: 0.0, totalMinutes: 0, totalWorkouts: 0);

  int _totalWorkouts = 0;
  int _totalMinutes = 0;
  double _totalKcal = 0;

  String _week = "";
  int _totalWeeklyWorkouts = 0;
  int _totalWeeklyMinutes = 0;
  double _totalWeeklyKcal = 0;

  List<HistoryWorkoutDay> _listHistory = [];
  List<Day> _listDay = [];
  List<ChartData> _listData = [];

  double _totalDailyKcal = 0;
  int _totalDailyMinute = 0;
  int _totalDailyWorkout = 0;

  bool _isLoadingWorkouts = false;
  bool _isLoadingChart = false;
  bool _isLoadingWorkoutHome = false;

  DateTime _currentTime = DateTime.now();
  late DateTime startOfWeek =
      _currentTime.subtract(Duration(days: currentTime.weekday - 1));
  late DateTime endOfWeek = currentTime
      .add(Duration(days: DateTime.daysPerWeek - currentTime.weekday));

  DateTime get getStartOfWeek => startOfWeek;

  DateTime get getEndOfWeek => endOfWeek;

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
  set listHistory(List<HistoryWorkoutDay> newVal) {
    _listHistory = newVal;
    notifyListeners();
  }

  List<Day> get listDay => _listDay;
  set listDay(List<Day> newVal) {
    _listDay = newVal;
    notifyListeners();
  }

  List<ChartData> get listData => _listData;
  set listData(List<ChartData> newVal) {
    _listData = newVal;
    notifyListeners();
  }

  bool get isLoadingWorkouts => _isLoadingWorkouts;
  set isLoadingWorkouts(newVal) {
    _isLoadingWorkouts = newVal;
    notifyListeners();
  }

  bool get isLoadingChart => _isLoadingChart;
  set isLoadingChart(newVal) {
    _isLoadingChart = newVal;
    notifyListeners();
  }

  bool get isLoadingWorkoutHome => _isLoadingWorkoutHome;
  set isLoadingWorkoutHome(newVal) {
    _isLoadingWorkoutHome = newVal;
    notifyListeners();
  }

  DateTime get currentTime => _currentTime;
  set currentTime(newVal) {
    _currentTime = newVal;
    notifyListeners();
  }

  double get totalDailyKcal => _totalDailyKcal;
  set totalDailyKcal(newVal) {
    _totalDailyKcal = newVal;
    notifyListeners();
  }

  int get totalDailyMinute => _totalDailyMinute;
  set totalDailyMinute(newVal) {
    _totalDailyMinute = newVal;
    notifyListeners();
  }

  int get totalDailyWorkout => _totalDailyWorkout;
  set totalDailyWorkout(newVal) {
    _totalDailyWorkout = newVal;
    notifyListeners();
  }

  void plusTotalDailyHistory(int workouts, int minute, double kcal) {
    totalDailyWorkout += workouts;
    totalDailyMinute += minute;
    totalDailyKcal += kcal;
    notifyListeners();
  }

  void changeCalendar(bool isPrevious) {
    if (isPrevious) {
      currentTime = currentTime.subtract(const Duration(days: 7));
      startOfWeek =
          currentTime.subtract(Duration(days: currentTime.weekday - 1));
      endOfWeek = currentTime
          .add(Duration(days: DateTime.daysPerWeek - currentTime.weekday));
    } else {
      currentTime = currentTime.add(const Duration(days: 7));
      startOfWeek =
          currentTime.subtract(Duration(days: currentTime.weekday - 1));
      endOfWeek = currentTime
          .add(Duration(days: DateTime.daysPerWeek - currentTime.weekday));
    }
    notifyListeners();
  }

  String getDay(int x) {
    int day = startOfWeek.add(Duration(days: x)).day;
    int month = startOfWeek.add(Duration(days: x)).month;
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

    String weekFormatted = "$formattedStartOfWeek-$formattedEndOfWeek";

    week = weekFormatted;
    totalWeeklyWorkouts += workouts;
    totalWeeklyMinutes += minutes;
    totalWeeklyKcal += kcal;
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
        .collection("workoutsHistory")
        .doc(user!.uid)
        .set(totalWorkoutsFromDB.toMap());
  }

  Future<void> getTotalWorkoutFromFirebase() async {
    FirebaseFirestore firebasefirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    await firebasefirestore
        .collection("workoutsHistory")
        .doc(user?.uid)
        .get()
        .then((value) {
      if (value.data() == null) {
        totalWorkouts = 0;
        totalMinutes = 0;
        totalKcal = 0.0;
      } else {
        totalWorkoutsFromDB = TotalWorkouts.fromMap(value.data());

        totalWorkouts = totalWorkoutsFromDB.totalWorkouts;
        totalMinutes = totalWorkoutsFromDB.totalMinutes;
        totalKcal = totalWorkoutsFromDB.totalKcal;
      }
    });
  }

  reset() {
    totalWorkouts = 0;
    totalMinutes = 0;
    totalKcal = 0.0;
    totalWorkoutsFromDB = TotalWorkouts();
    //week = "";
    totalWeeklyKcal = 0.0;
    totalWeeklyMinutes = 0;
    totalWeeklyWorkouts = 0;
    listHistory = [];
    listDay = [];
  }

  resetHistoryChart({int i = 1}) {
    if (i == 1) {
      listData = [];
    } else {
      Future.delayed(const Duration(milliseconds: 700), () => listData = []);
    }
    listHistory = [];
    totalWeeklyWorkouts = 0;
    totalWeeklyKcal = 0.0;
    totalWeeklyMinutes = 0;
    week = "";
  }

  resetTime() {
    currentTime = DateTime.now();
    startOfWeek =
        _currentTime.subtract(Duration(days: currentTime.weekday - 1));
    endOfWeek = currentTime
        .add(Duration(days: DateTime.daysPerWeek - currentTime.weekday));
  }

  String getSubDocument(BuildContext context) {
    String formattedStartOfWeek = DateFormat('ddMMyy').format(getStartOfWeek);
    String formattedEndOfWeek = DateFormat('ddMMyy').format(getEndOfWeek);
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

  Future<void> getHistoryWorkoutsFromFirebase(
      BuildContext context, String subDocument) async {
    isLoadingWorkouts = true;
    String subDoc = getSubDocument(context);
    subDocument != "" ? subDocument = subDocument : subDocument = subDoc;

    for (int i = 0; i < 7; i++) {
      await FirebaseFirestore.instance
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
          notifyListeners();
          isLoadingWorkouts = false;
        },
      );
    }
    isLoadingWorkouts = false;
  }

  Future pushTotalWeeklyHistoryToFirestore(
      BuildContext context, String subDocument) async {
    FirebaseFirestore firebasefirestore = FirebaseFirestore.instance;

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

  Future<void> getTotalWeeklyHistoryToFirestore(
      BuildContext context, String subDocument) async {
    isLoadingWorkouts = true;
    FirebaseFirestore firebasefirestore = FirebaseFirestore.instance;

    String subDoc = getSubDocument(context);
    subDocument != "" ? subDocument = subDocument : subDocument = subDoc;

    await firebasefirestore
        .collection("workoutsHistory")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("list")
        .doc(subDocument)
        .get()
        .then((value) {
      if (value.data() == null) {
        totalWeekly = TotalWeekly(
            week: "", totalKcal: 0.0, totalMinutes: 0, totalWorkouts: 0);
      } else {
        totalWeekly = TotalWeekly.fromMap(value.data());
      }
      isLoadingWorkouts = false;
    });

    isLoadingWorkouts = false;

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

  Future<void> getHistoryWorkoutsChartFromFireStore(
      BuildContext context, String subDocument) async {
    isLoadingChart = true;
    String subDoc = getSubDocument(context);
    subDocument != "" ? subDocument = subDocument : subDocument = subDoc;

    for (int i = 0; i < 7; i++) {
      await FirebaseFirestore.instance
          .collection("workoutsHistory")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("list")
          .doc(subDocument)
          .collection("chart")
          .doc(getDay(i))
          .get()
          .then(
        (value) {
          if (value.data() == null) {
            listData.add(ChartData(totalKcalDay: 0.0));
          } else {
            listData.add(ChartData.fromMap(value.data()));
          }
          notifyListeners();
        },
      );
    }

    if (listData.length == 7) {
      isLoadingChart = false;
    }
    notifyListeners();
  }

  Future<void> getTotalDailyWorkoutsFromFireStore(
      BuildContext context, String subDocument) async {
    String subDoc = getSubDocument(context);
    subDocument != "" ? subDocument = subDocument : subDocument = subDoc;
    await FirebaseFirestore.instance
        .collection("workoutsHistory")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("list")
        .doc(subDocument)
        .collection("chart")
        .doc(getCurrentDay())
        .get()
        .then(
      (value) {
        if (value.data() == null) {
          totalDailyKcal = 0.0;
          totalDailyWorkout = 0;
          totalDailyMinute = 0;
        } else {
          totalDailyKcal = ChartData.fromMap(value.data()).totalKcalDay;
          totalDailyMinute = ChartData.fromMap(value.data()).totalMinuteDay;
          totalDailyWorkout = ChartData.fromMap(value.data()).totalWorkoutsDay;
        }
        _isLoadingWorkoutHome = true;
        notifyListeners();
      },
    );
  }

  Future pushTotalDailyWorkoutsToFireStore(BuildContext context) async {
    FirebaseFirestore firebasefirestore = FirebaseFirestore.instance;
    final charData = ChartData();

    charData.totalKcalDay = totalDailyKcal;
    charData.totalMinuteDay = totalDailyMinute;
    charData.totalWorkoutsDay = totalDailyWorkout;

    await firebasefirestore
        .collection("workoutsHistory")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("list")
        .doc(getSubDocument(context))
        .collection("chart")
        .doc(getCurrentDay())
        .set(charData.toJson());
  }
}
