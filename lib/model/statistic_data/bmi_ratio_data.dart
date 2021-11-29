import 'package:wecare_flutter/constants/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BMIRatio {
  double? ratio;
  int? status;
  DateTime? updatedDate;

  BMIRatio({
    this.ratio,
    this.status,
    this.updatedDate,
  });

  // still don't know what this class is used for
  Map<String, dynamic> toJson() {
    return {
      FireStoreConstants.bmiRatio: ratio,
      FireStoreConstants.timestamp: updatedDate,
      FireStoreConstants.status: status,
    };
  }

  // Get specified fields in a document of a collection in firebase
  factory BMIRatio.fromDocument(DocumentSnapshot doc) {
    Timestamp timestamp = doc['timestamp'];
    return BMIRatio(
      ratio: doc['ratio'],
      status: doc['status'],
      updatedDate: timestamp.toDate(),
    );
  }
}

//this class don;t need to be saved on Firebase
class BMIRatioHistory {
  List<BMIRatio> bmiRatioHistoryList;

  BMIRatioHistory({required this.bmiRatioHistoryList});

  set setBMIRatioHistoryList(newValue) {
    bmiRatioHistoryList = newValue;
  }

  get getRatioHistoryList => bmiRatioHistoryList;
}
