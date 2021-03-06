import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/firestore_constants.dart';
import 'package:wecare_flutter/model/statistic_data/bmi_ratio_data.dart';
import 'package:wecare_flutter/services/authentic_service.dart';

class BMIHistoryViewModel extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;

  BMIRatio _bmiRatio = BMIRatio();

  BMIRatio get bmiRatio => _bmiRatio;

  DateTime now = DateTime.now();

  BMIHistoryViewModel(BuildContext context) {
    getDataFromFirestore();
    getQuerySnapshot();
    notifyListeners();
  }

  double calculateBMIratio(double height, double weight) {
    return double.parse(
        (weight / ((height * height) * 0.0001)).toStringAsFixed(2));
  }

  void resetInfo() {
    _bmiRatio.ratio = 0;
    _bmiRatio.updatedDate = DateTime.now();
  }

  Future<void> pushRatioToFirestore(BuildContext context) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    final AuthenticService authenticService =
        Provider.of<AuthenticService>(context, listen: false);

    bmiRatio.ratio = calculateBMIratio(authenticService.loggedInUser.height!,
        authenticService.loggedInUser.weight!);
    bmiRatio.updatedDate = now;

    String formattedNow = DateFormat('dd-MM-yyyy-hh-mm').format(now);

    await firebaseFirestore
        .collection(FireStoreConstants.pathBMICollection)
        .doc(authenticService.loggedInUser.uid)
        .set(bmiRatio.toJson())
        .catchError((e) {});
    await firebaseFirestore
        .collection(FireStoreConstants.pathBMICollection)
        .doc(authenticService.loggedInUser.uid)
        .collection(FireStoreConstants.bmiHistory)
        .doc(formattedNow)
        .set(bmiRatio.toJson());
    notifyListeners();
  }

  Future<void> getDataFromFirestore() async {
    await FirebaseFirestore.instance
        .collection(FireStoreConstants.pathBMICollection)
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((value) {
      if (value.data() == null) {
      } else {
        _bmiRatio = BMIRatio.fromDocument(value);
      }
    });
    notifyListeners();
  }

  Future<List> getQuerySnapshot() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(FireStoreConstants.pathBMICollection)
        .doc(_firebaseAuth.currentUser?.uid)
        .collection(FireStoreConstants.bmiHistory)
        .get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }
}