import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/constants/firestore_constants.dart';
import 'package:wecare_flutter/model/wecare_user.dart';
import 'package:wecare_flutter/services/authentic_service.dart';

class EditProfileViewModel extends ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  WeCareUser _weCareUser = WeCareUser();

  var nameController = TextEditingController();
  var weightController = TextEditingController();
  var heightController = TextEditingController();
  var wakeupTimeController = TextEditingController();
  var sleepTimeController = TextEditingController();

  WeCareUser get getCurrentUser => _weCareUser;

  bool _isValidName = true;
  bool _isValidWeight = true;
  bool _isValidHeight = true;

  get isValidName => _isValidName;
  get isValidWeight => _isValidWeight;
  get isValidHeight => _isValidHeight;

  var selectedSleepTime = const TimeOfDay(hour: 22, minute: 00);
  var selectedWakeupTime = const TimeOfDay(hour: 7, minute: 00);

  get getSleepTime => selectedSleepTime;
  get getWakeupTime => selectedWakeupTime;

  //! This function is fine
  Future<void> showPicker(BuildContext context, TimeOfDay selectedTime,
      TextEditingController timeController) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            primaryColor: primaryColor,
            backgroundColor: primaryColor,
            dialogBackgroundColor: primaryColor,
          ),
          child: child!,
        );
      },
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      selectedTime = timeOfDay;
      timeController.text = selectedTime.format(context);
      notifyListeners();
    }
  }

  String? nameValidator(value) {
    if (value.length >= 6 || value.isEmpty || value == null || value == "") {
      _isValidName = true;
      return null;
    } else {
      _isValidName = false;
      return 'Invalid name';
    }
  }

  String? heightValidator(String? value) {
    if (value!.isEmpty) {
      _isValidHeight = true;
      return null;
    } else {
      if (int.parse(value) >= 20 && int.parse(value) <= 300) {
        _isValidHeight = true;
        return null;
      } else {
        _isValidHeight = false;
        return 'Invalid height!';
      }
    }
  }

  String? weightValidator(String? value) {
    if (value!.isEmpty) {
      _isValidWeight = true;
      return null;
    } else {
      if ((int.parse(value) >= 10 && int.parse(value) <= 150) ||
          value.isEmpty) {
        _isValidWeight = true;
        return null;
      } else {
        _isValidWeight = false;
        return 'Invalid weight!';
      }
    }
  }

  EditProfileViewModel() {
    getInformationFromFirestore();
    notifyListeners();
  }

  Future<void> getInformationFromFirestore() async {
    await FirebaseFirestore.instance
        .collection(FireStoreConstants.pathUserCollection)
        .doc(_firebaseAuth.currentUser?.uid)
        .get()
        .then((value) {
      _weCareUser = WeCareUser.fromMap(value.data());
    });
    notifyListeners();
  }

  Future<void> updateUserDatatoFirestore(BuildContext context) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    final AuthenticService authenticService =
        Provider.of<AuthenticService>(context, listen: false);

    var now = DateTime.now();
    DateTime dateTimeSleep = DateTime(
        now.year,
        now.month,
        now.day,
        authenticService.loggedInUser.sleepTime!.hour,
        authenticService.loggedInUser.sleepTime!.minute);
    print(sleepTimeController.text);
    print(dateTimeSleep);
      
    DateTime dateTimeWakeup = DateTime(now.year, now.month, now.day,
        selectedWakeupTime.hour, selectedWakeupTime.minute);

    Map<String, dynamic> newDataJson() {
      return {
        "name": nameController.text.isEmpty
            ? authenticService.loggedInUser.name
            : nameController.text,
        "weight": double.tryParse(weightController.text.isEmpty
            ? authenticService.loggedInUser.weight.toString()
            : weightController.text),
        "height": double.tryParse(heightController.text.isEmpty
            ? authenticService.loggedInUser.height.toString()
            : heightController.text),
        "sleepTime": dateTimeSleep,
        "wakeupTime": dateTimeWakeup,
      };
    }

    await firebaseFirestore
        .collection(FireStoreConstants.pathUserCollection)
        .doc(authenticService.loggedInUser.uid)
        .set(
          newDataJson(),
          SetOptions(merge: true),
        )
        .catchError((e) {});
    notifyListeners();
  }

  void updateToLoggedInUser(BuildContext context) {
    var now = DateTime.now();
    final AuthenticService authenticService =
        Provider.of<AuthenticService>(context, listen: false);

    if (nameController.text.isEmpty == false) {
      authenticService.loggedInUser.name = nameController.text;
    }
    if (weightController.text.isEmpty == false) {
      authenticService.loggedInUser.weight =
          double.parse(weightController.text);
    }
    if (heightController.text.isEmpty == false) {
      authenticService.loggedInUser.height =
          double.parse(heightController.text);
    }
    if (sleepTimeController.text.isEmpty == false) {
      DateTime dateTimeSleep = DateTime(now.year, now.month, now.day,
          selectedSleepTime.hour, selectedSleepTime.minute);
      authenticService.loggedInUser.sleepTime = dateTimeSleep;
    }
    if (wakeupTimeController.text.isEmpty == false) {
      DateTime dateTimeWakeup = DateTime(now.year, now.month, now.day,
          selectedWakeupTime.hour, selectedWakeupTime.minute);
      authenticService.loggedInUser.wakeupTime = dateTimeWakeup;
    }
  }
}
