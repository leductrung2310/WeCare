import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wecare_flutter/constants/firestore_constants.dart';
import 'package:wecare_flutter/model/statistic_data/bmi_ratio_data.dart';
import 'package:wecare_flutter/model/wecare_user.dart';
import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/screen/main_screen.dart';
import 'package:wecare_flutter/services/authentic_service.dart';

class RegisterViewModel extends ChangeNotifier {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var dateOfBirthController = TextEditingController();
  var heightController = TextEditingController();
  var weightController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(newValue) {
    _isLoading = newValue;
    notifyListeners();
  }

  bool _isValidEmail = false;
  get isValid => _isValidEmail;

  void isValidEmail(String value) {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      _isValidEmail = true;
    } else {
      _isValidEmail = false;
    }
    notifyListeners();
  }

  bool _isVisible = false;
  get isVisible => _isVisible;

  set isVisible(value) {
    _isVisible = value;
    notifyListeners();
  }

  bool _isConfirmVisible = false;
  get isConfirmVisible => _isConfirmVisible;

  set isConfirmVisible(value) {
    _isConfirmVisible = value;
    notifyListeners();
  }

  int _gender = 0;
  get gender => _gender;

  set gender(value) {
    _gender = value;
    notifyListeners();
  }

  String? passwordValidator(text) {
    if (text.toString().length < 6 || text == "") {
      return 'Invalid Password';
    }
    return null;
  }

  String? passwordRepeatValidator(text) {
    if (text == "") return 'Invalid Password';
    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      return 'Password does not Match';
    }
    return null;
  }

  String? emailValidator(text) {
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(text) ||
        text == "") return 'Invalid Email';
    return null;
  }

  String? nameValidator(text) {
    if (text == "") return 'Invalid Email';
    return null;
  }

  bool onNextClick() {
    if (emailController.text.isNotEmpty) {
      return true;
    }
    if (emailValidator(emailController.text) == "") {
      return true;
    }
    return false;
  }

  Future<void> pushUserToFireStore(BuildContext context) async {
    String? name = nameController.text.trim();
    isLoading = true;
    User? user = FirebaseAuth.instance.currentUser;
    WeCareUser weCareUser = WeCareUser();
    FirebaseFirestore firebasefirestor = FirebaseFirestore.instance;

    DateTime dateTime =
        DateFormat("dd/MM/yyyy").parse(dateOfBirthController.text);
    DateTime now = DateTime.now();
    DateTime sleepDateTime = DateTime(now.year, now.month, now.day, 22, 0);
    DateTime wakeupDateTime = DateTime(now.year, now.month, now.day, 7, 0);
    weCareUser.email = user?.email;
    weCareUser.uid = user?.uid;
    weCareUser.name = user?.displayName ?? name;
    weCareUser.avatarUrl =
        "https://firebasestorage.googleapis.com/v0/b/wecare-da049.appspot.com/o/default_avatar.png?alt=media&token=2c3cb547-e2d2-4e14-a6da-ee15b04ccb6e";
    weCareUser.birthDay = dateTime;
    weCareUser.age = DateTime.now().year - dateTime.year;
    weCareUser.height = double.parse(heightController.text);
    weCareUser.weight = double.parse(weightController.text);
    weCareUser.sleepTime = sleepDateTime;
    weCareUser.wakeupTime = wakeupDateTime;
    if (gender == 1) {
      weCareUser.gender = true;
    } else {
      weCareUser.gender = false;
    }
    weCareUser.sleepTime = sleepDateTime;
    weCareUser.wakeupTime = wakeupDateTime;

    await firebasefirestor
        .collection("users")
        .doc(user!.uid)
        .set(weCareUser.toMap());
    isLoading = false;
  }

  double calculateBMIratio(double? height, double? weight) {
    return double.parse(
        ((weight ?? 10) / ((height ?? 30) * 0.02)).toStringAsFixed(2));
  }

  Future<void> pushRatioToFirestore(BuildContext context) async {
    double? height = double.parse(heightController.text);
    double? weight = double.parse(weightController.text);
    double ratio = calculateBMIratio(height, weight);

    BMIRatio bmiRatio = BMIRatio(ratio: ratio, updatedDate: DateTime.now());

    String formattedNow = DateFormat('dd-MM-yyyy-hh-mm').format(DateTime.now());

    await FirebaseFirestore.instance
        .collection(FireStoreConstants.pathBMICollection)
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(bmiRatio.toJson())
        .catchError((e) {});
    await FirebaseFirestore.instance
        .collection(FireStoreConstants.pathBMICollection)
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection(FireStoreConstants.bmiHistory)
        .doc(formattedNow)
        .set(bmiRatio.toJson());
    notifyListeners();
  }

  Future<void> completeRegister(BuildContext context) async {
    await pushUserToFireStore(context);
    await pushRatioToFirestore(context);
    await pushFoodHistoryToFireStore();
    isLoading = false;
    Navigator.of(context).pushReplacementNamed(Routes.main);
    Fluttertoast.showToast(msg: "Account successfully created! Enjoy!");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        'uid', FirebaseAuth.instance.currentUser?.uid ?? 'nulluser');
  }

  pushFoodHistoryToFireStore() async {
    await FirebaseFirestore.instance
        .collection("foodHistory")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      '1': '',
      '2': '',
      '3': '',
      '4': '',
      '5': '',
    });
  }

  void reset() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    dateOfBirthController = TextEditingController();
    heightController = TextEditingController();
    weightController = TextEditingController();
    _isLoading = false;
    _isValidEmail = false;
    _isVisible = false;
    _isConfirmVisible = false;
    _gender = 0;
  }
}
