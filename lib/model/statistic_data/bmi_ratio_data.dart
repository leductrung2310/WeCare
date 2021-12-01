import 'package:wecare_flutter/constants/firestore_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BMIRatio {
  double? ratio;
  DateTime? updatedDate;

  BMIRatio({
    this.ratio,
    this.updatedDate,
  });

  Map<String, dynamic> toJson() {
    return {
      FireStoreConstants.bmiRatio: ratio,
      FireStoreConstants.timestamp: updatedDate,
    };
  }

  // Get specified fields in a document of a collection in firebase
  factory BMIRatio.fromDocument(DocumentSnapshot doc) {
    Timestamp timestamp = doc[FireStoreConstants.timestamp];
    return BMIRatio(
      ratio: doc[FireStoreConstants.bmiRatio],
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
