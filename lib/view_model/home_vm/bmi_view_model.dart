import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/firestore_constants.dart';
import 'package:wecare_flutter/model/statistic_data/bmi_ratio_data.dart';
import 'package:wecare_flutter/services/authentic_service.dart';

class BMIHistoryViewModel extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  final BMIRatioHistory bmiRatioHistory =
      BMIRatioHistory(bmiRatioHistoryList: []);

  BMIRatio _bmiRatio = BMIRatio();

  BMIRatio get bmiRatio => _bmiRatio;

  DateTime now = DateTime.now();

  //App needed to restart to update
  BMIHistoryViewModel(BuildContext context) {
    getDataFromFirestore();
    pushRatioToFirestore(context);
    notifyListeners();
  }

  //! null check operator
  double calculateBMIratio(double? height, double? weight) {
    return double.parse((weight! / (height! * 0.02)).toStringAsFixed(2));
  }

  int calculateStatus(double? ratio) {
    int status = 0;
    if (ratio! >= 16 && ratio <= 18.5) {
      status = 1;
    }
    if (ratio >= 18.6 && ratio <= 25) {
      status = 2;
    }
    if (ratio >= 25.1 && ratio <= 40) {
      status = 3;
    }
    return status;
  }

  void pushRatioToFirestore(BuildContext context) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _firebaseAuth.currentUser;

    //! edit here
    final AuthenticService authenticService =
        Provider.of<AuthenticService>(context, listen: false);
    double ratio = calculateBMIratio(authenticService.loggedInUser.height,
        authenticService.loggedInUser.weight);
    int status = calculateStatus(ratio);

    BMIRatio bmiRatio = BMIRatio();

    bmiRatio.ratio = ratio;
    bmiRatio.status = status;
    bmiRatio.updatedDate = now;

    await firebaseFirestore
        .collection(FireStoreConstants.pathBMICollection)
        .doc(user?.uid)
        .set(bmiRatio.toJson())
        .catchError((e) {});
    notifyListeners();
  }

  Future<void> getDataFromFirestore() async {
    print('phat' + _firebaseAuth.currentUser!.uid.toString());
    await FirebaseFirestore.instance
        .collection(FireStoreConstants.pathBMICollection)
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((value) {
      if (value.data() == null) {
        print('phat nill');
      } else {
        print('phat dep');
        _bmiRatio = BMIRatio.fromDocument(value);
      }
    });
    notifyListeners();
  }
}
