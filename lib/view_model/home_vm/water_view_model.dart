import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/model/statistic_data/water_statistic_data.dart';
import 'package:wecare_flutter/services/authentic_service.dart';

import '../../constants/firestore_constants.dart';

class WaterViewModel extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;

  WaterData _waterData = WaterData(waterIndex: 0, drinkTimes: 0, id: 0);

  WaterData get waterData => _waterData;

  double _drinkAmount = 0.3;

  set setDrinkAmount(double newValue) {
    _drinkAmount = newValue;
  }

  get getDrinkAmount => _drinkAmount;

  double calculateCurrentIndex(double drinkAmount1) {
    _waterData.waterIndex = _waterData.waterIndex + (drinkAmount1);
    notifyListeners();
    return waterData.waterIndex;
  }

  double get getCurrentIndex => _waterData.waterIndex;

  int calculateDrinkTimes() {
    _waterData.drinkTimes += 1;
    return waterData.drinkTimes;
  }

  int get getCurrentDrinkTimes => _waterData.drinkTimes;

  late DateTime startOfWeek;
  late DateTime endOfWeek;

  DateTime currentTime = DateTime.now();

  DateTime calculateStartOfWeek() {
    return startOfWeek =
        currentTime.subtract(Duration(days: currentTime.weekday - 1));
  }

  DateTime calculateEndOfWeek() {
    return endOfWeek = currentTime
        .add(Duration(days: DateTime.daysPerWeek - currentTime.weekday));
  }

  String formatDateTime(bool isCollection, DateTime dateTime) {
    if (isCollection) {
      return DateFormat('ddMMyyyy').format(dateTime);
    } else {
      return DateFormat('dd-MM').format(dateTime);
    }
  }

  void calculateDailyID() {
    _waterData.id = DateTime.now().weekday;
  }

  final List<WaterData> _waterHistory = [];

  get getWaterHistoryList => _waterHistory;

  double _averageIndex = 0;

  get getAverageIndex => _averageIndex;

  double _averageCompletedPercent = 0;

  get getAveragePercent => _averageCompletedPercent;

  double _averageDrinkTimes = 0;

  get getAverageDrinkTimes => _averageDrinkTimes;

  int _reminderTimes = 0;

  get getreminderTimes => _reminderTimes;

  void calculateReminderNumber(BuildContext context) {
    double desiredAmount = Provider.of<AuthenticService>(context).getDesiredAmount;
    _reminderTimes = desiredAmount ~/ _drinkAmount;
  }

  WaterViewModel(BuildContext context) {
    calculateStartOfWeek();
    calculateEndOfWeek();
    getDataFromFirestore();
    notifyListeners();
  }

  Future<void> pushDataToFirestore(BuildContext context) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    String colPath =
        '${formatDateTime(true, calculateStartOfWeek())}-${formatDateTime(true, calculateEndOfWeek())}';
    String docPath = formatDateTime(false, currentTime);

    AuthenticService authenticService =
        Provider.of<AuthenticService>(context, listen: false);

    if (_waterData.waterIndex >= authenticService.getDesiredAmount + 0.5) {
      _waterData.waterIndex = authenticService.getDesiredAmount + 0.5;
    }

    _waterData.id = DateTime.now().weekday;

    await firebaseFirestore
        .collection(FireStoreConstants.pathWaterCollection)
        .doc(_firebaseAuth.currentUser?.uid)
        .collection(colPath)
        .doc(docPath)
        .set(waterData.toJson())
        .catchError((e) {});
    notifyListeners();
  }

  Future<void> pushDataToFirestore2(BuildContext context) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    DateTime currentTime = DateTime.now();
    startOfWeek = currentTime.subtract(Duration(days: currentTime.weekday - 1));

    String colPath =
        '${formatDateTime(true, calculateStartOfWeek())}-${formatDateTime(true, calculateEndOfWeek())}';

    AuthenticService authenticService =
        Provider.of<AuthenticService>(context, listen: false);

    if (_waterData.waterIndex >= authenticService.getDesiredAmount + 0.5) {
      _waterData.waterIndex = authenticService.getDesiredAmount + 0.5;
    }

    for (int i = currentTime.weekday; i <= 7; i++) {
      DateTime dateTime = startOfWeek.add(Duration(days: i - 1));
      var secondeData = WaterData(drinkTimes: 0, waterIndex: 0, id: i);
      await firebaseFirestore
          .collection(FireStoreConstants.pathWaterCollection)
          .doc(_firebaseAuth.currentUser?.uid)
          .collection(colPath)
          .doc(formatDateTime(false, dateTime))
          .set(formatDateTime(true, dateTime) ==
                  formatDateTime(true, currentTime)
              ? _waterData.toJson()
              : secondeData.toJson())
          .catchError((e) {});
    }
    notifyListeners();
  }

  Future<void> getDataFromFirestore() async {
    String colPath =
        '${formatDateTime(true, calculateStartOfWeek())}-${formatDateTime(true, calculateEndOfWeek())}';
    String docPath = formatDateTime(false, currentTime);
    await FirebaseFirestore.instance
        .collection(FireStoreConstants.pathWaterCollection)
        .doc(_firebaseAuth.currentUser?.uid)
        .collection(colPath)
        .doc(docPath)
        .get()
        .then((value) {
      _waterData = WaterData.fromDocument(value);
      //todo: Catch errors
    }).catchError((e) => Fluttertoast.showToast(msg: "Let's start to drink"));
    notifyListeners();
  }

  Future<void> getQuerySnapshot() async {
    String colPath =
        '${formatDateTime(true, calculateStartOfWeek())}-${formatDateTime(true, calculateEndOfWeek())}';
    await FirebaseFirestore.instance
        .collection(FireStoreConstants.pathWaterCollection)
        .doc(_firebaseAuth.currentUser?.uid)
        .collection(colPath)
        .get()
        .then((value) {
      var docSnapshots = value.docs;
      for (var i in docSnapshots) {
        var doc = i.data();
        if (_waterHistory.length >= docSnapshots.length) {
          _waterHistory.clear();
        }
        _waterHistory.add(WaterData.fromMap(doc));
      }
    });
    notifyListeners();
  }

  void calculateAverage(BuildContext context) {
    //* Average weekly index
    double indexTotal = 0;
    List indexesList = _waterHistory.map((data) => data.waterIndex).toList();
    for (int i = 0; i < indexesList.length; i++) {
      indexTotal = indexTotal + indexesList.elementAt(i);
    }
    _averageIndex = (indexTotal / 7) * 1000;

    //* Average percentage index
    double desiredAmount =
        Provider.of<AuthenticService>(context, listen: false).getDesiredAmount;
    _averageCompletedPercent = (indexTotal / (desiredAmount * 7)) * 100;

    //* Average weekly drink times
    double drinkTimesTotal = 0;
    List drinkTimesList = _waterHistory.map((data) => data.drinkTimes).toList();
    for (int i = 0; i < drinkTimesList.length; i++) {
      drinkTimesTotal = drinkTimesTotal + drinkTimesList.elementAt(i);
    }
    _averageDrinkTimes = drinkTimesTotal / 7;
  }
}
