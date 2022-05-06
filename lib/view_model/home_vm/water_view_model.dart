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

  DateTime calculateStartOfWeek(DateTime dateTime) {
    return startOfWeek =
        dateTime.subtract(Duration(days: currentTime.weekday - 1));
  }

  DateTime calculateEndOfWeek(DateTime dateTime) {
    return endOfWeek = dateTime
        .add(Duration(days: DateTime.daysPerWeek - currentTime.weekday));
  }

  String formatDateTime(bool isCollection, DateTime dateTime) {
    if (isCollection) {
      return DateFormat('ddMMyyyy').format(dateTime);
    } else {
      return DateFormat('dd-MM').format(dateTime);
    }
  }

  List<WaterData> _waterHistory = [];

  set waterHistory(newVal) {
    _waterHistory = newVal;
    notifyListeners();
  }

  get getWaterHistoryList => _waterHistory;

  double _averageIndex = 0;

  get getAverageIndex => _averageIndex;

  double _averageCompletedPercent = 0;

  get getAveragePercent => _averageCompletedPercent;

  double _averageDrinkTimes = 0;

  get getAverageDrinkTimes => _averageDrinkTimes;

  bool _isLoadingStatisticInfo = true;

  set setIsLoading(newVal) {
    _isLoadingStatisticInfo = newVal;
    notifyListeners();
  }

  bool get getIsLoadingInfo => _isLoadingStatisticInfo;

  WaterViewModel(BuildContext context) {
    calculateStartOfWeek(currentTime);
    calculateEndOfWeek(currentTime);
    getDataFromFirestore();
    notifyListeners();
  }

  void reset() {
    _waterData.drinkTimes = 0;
    _waterData.waterIndex = 0;
    _waterData.id = 0;
    _waterHistory.clear();
    _averageIndex = 0;
    _averageDrinkTimes = 0;
    _averageCompletedPercent = 0;
    _drinkAmount = 0.3;
    notifyListeners();
  }

  Future<void> resetChart() async {
    _waterHistory.clear();
    _averageIndex = 0;
    _averageDrinkTimes = 0;
    _averageCompletedPercent = 0;
    _isLoadingStatisticInfo = false;
    currentTime = DateTime.now();
    notifyListeners();
  }

  Future<void> pushDataToFirestore(BuildContext context) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    String colPath =
        '${formatDateTime(true, calculateStartOfWeek(currentTime))}-${formatDateTime(true, calculateEndOfWeek(currentTime))}';
    String docPath = formatDateTime(false, currentTime);

    AuthenticService authenticService =
        Provider.of<AuthenticService>(context, listen: false);

    if (_waterData.waterIndex >= authenticService.getDesiredAmount + 1) {
      _waterData.waterIndex = authenticService.getDesiredAmount + 1;
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

    String colPath =
        '${formatDateTime(true, calculateStartOfWeek(currentTime))}-${formatDateTime(true, calculateEndOfWeek(currentTime))}';

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
        '${formatDateTime(true, calculateStartOfWeek(currentTime))}-${formatDateTime(true, calculateEndOfWeek(currentTime))}';
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
      // ignore: invalid_return_type_for_catch_error
    }).catchError((e) => Fluttertoast.showToast(msg: "Let's start to drink"));
    notifyListeners();
  }

  Future<void> getQuerySnapshot(int isLastWeek) async {
    _waterHistory = [];
    _isLoadingStatisticInfo = true;
    if (isLastWeek == -1) {
      currentTime = currentTime.subtract(const Duration(days: 7));
    }
    if (isLastWeek == 1) {
      currentTime = currentTime.add(const Duration(days: 7));
    }

    String colPath =
        '${formatDateTime(true, calculateStartOfWeek(currentTime))}-${formatDateTime(true, calculateEndOfWeek(currentTime))}';
    _waterHistory.clear();

    await FirebaseFirestore.instance
        .collection(FireStoreConstants.pathWaterCollection)
        .doc(_firebaseAuth.currentUser?.uid)
        .collection(colPath)
        .get()
        .then((values) {
      var docSnapshots = values.docs;
      for (var j in docSnapshots) {
        var doc = j.data();
        _waterHistory.add(WaterData.fromMap(doc));
      }
    });

    addMissedItemToList();
    _isLoadingStatisticInfo = false;
    notifyListeners();
  }

  void addMissedItemToList() {
    int missedItem = 7 - _waterHistory.length;
    for (int i = 1; i <= missedItem; i++) {
      _waterHistory.insert(
        i - 1,
        WaterData(
          waterIndex: 0,
          drinkTimes: 0,
          id: i,
        ),
      );
    }
  }

  Future<void> calculateAverage(BuildContext context) async {
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
