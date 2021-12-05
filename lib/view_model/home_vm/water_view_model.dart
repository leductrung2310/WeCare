import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/model/statistic_data/water_statistic_data.dart';

import '../../constants/firestore_constants.dart';
import '../../services/authentic_service.dart';

class WaterViewModel extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;

  WaterData _waterData = WaterData(waterIndex: 0, drinkTimes: 0);

  WaterData get waterData => _waterData;

  double? _desiredAmount;

  get desiredAmount => _desiredAmount;

  double? _drinkAmount = 0.3;

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

  double calculateDesiredAmount(BuildContext context) {
    final AuthenticService authenticService =
        Provider.of<AuthenticService>(context, listen: false);
    notifyListeners();
    return _desiredAmount = (authenticService.loggedInUser.weight ?? 10) * 0.03;
  }

  String formatDateTime(bool isCollection, DateTime dateTime) {
    if (isCollection) {
      return DateFormat('ddMMyyyy').format(dateTime);
    } else {
      return DateFormat('dd-MM').format(dateTime);
    }
  }

  List _waterHistory = [];

  get getWaterHistoryList => _waterHistory;

  WaterViewModel(BuildContext context) {
    calculateDesiredAmount(context);
    calculateStartOfWeek();
    calculateEndOfWeek();
    if (TimeOfDay.now().hour >= 23 && TimeOfDay.now().minute > 58) {
      _waterData.waterIndex = 0;
      _waterData.drinkTimes = 0;
    }
    getDataFromFirestore();
    notifyListeners();
  }

  Future<void> pushDataToFirestore(BuildContext context) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _firebaseAuth.currentUser;

    String colPath =
        '${formatDateTime(true, calculateStartOfWeek())}-${formatDateTime(true, calculateEndOfWeek())}';
    String docPath = formatDateTime(false, currentTime);

    await firebaseFirestore
        .collection(FireStoreConstants.pathWaterCollection)
        .doc(user?.uid)
        .set(waterData.toJson())
        .catchError((e) {});
    notifyListeners();

    await firebaseFirestore
        .collection(FireStoreConstants.pathWaterCollection)
        .doc(user?.uid)
        .collection(colPath)
        .doc(docPath)
        .set(waterData.toJson())
        .catchError((e) {});
    notifyListeners();
  }

  Future<void> getDataFromFirestore() async {
    await FirebaseFirestore.instance
        .collection(FireStoreConstants.pathWaterCollection)
        .doc(_firebaseAuth.currentUser?.uid)
        .get()
        .then((value) {
      _waterData = WaterData.fromDocument(value);
    });
    notifyListeners();
  }

  Future<List> getQuerySnapshot() async {
    String colPath =
        '${formatDateTime(true, calculateStartOfWeek())}-${formatDateTime(true, calculateEndOfWeek())}';
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(FireStoreConstants.pathWaterCollection)
        .doc(_firebaseAuth.currentUser?.uid)
        .collection(colPath)
        .get();
    notifyListeners();
    //return querySnapshot.docs.map((doc) => doc.data()).toList();
    return querySnapshot.docs;
  }

  Future<void> convertDocumentsToList() async {
    _waterHistory = await getQuerySnapshot();
  }

  Future<void> convertFutureToList() async {
    _waterHistory = await getQuerySnapshot();
  }
}
