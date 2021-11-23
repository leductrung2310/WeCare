import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wecare_flutter/model/bmi_ratio_data.dart';

class BMIHistoryViewModel extends ChangeNotifier {
  final BMIRatio bmiRatio = BMIRatio(
    ratio: 0,
    status: BMIStatus.normal,
    updatedDate: DateTime.now(),
  );

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final BMIRatioHistory bmiRatioHistory =
      BMIRatioHistory(bmiRatioHistoryList: []);

  // Todo: get updated information of user here
  double newHeight = 170;
  double newWeight = 64;

  BMIHistoryViewModel() {
    bmiRatio.ratio =
        double.parse((newWeight / (newHeight * 0.02)).toStringAsFixed(2));
    bmiRatioHistory.bmiRatioHistoryList.add(bmiRatio);
    notifyListeners();
  }

  String getUpdatedDate() {
    String formattedDate =
        DateFormat('dd-MM-yyyy').format(bmiRatio.updatedDate);
    return formattedDate;
  }

  void addNewBMIRatio() {
    bmiRatioHistory.bmiRatioHistoryList.add(bmiRatio);
    notifyListeners();
  }
}
