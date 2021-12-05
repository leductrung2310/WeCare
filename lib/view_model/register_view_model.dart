import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/model/wecare_user.dart';
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
    final auth = Provider.of<AuthenticService>(context, listen: false);
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

    auth.loggedInUser = weCareUser;
    await firebasefirestor
        .collection("users")
        .doc(user!.uid)
        .set(weCareUser.toMap());
    await pushFoodHistoryToFireStore();
    isLoading = false;
  }

  Future<void> completeRegister(BuildContext context) async {
    await pushUserToFireStore(context);

    isLoading = false;
    Future.delayed(
      const Duration(seconds: 1),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MainScreen(),
        ),
      ),
    );
    Fluttertoast.showToast(msg: "Account successfully created! Enjoy!");
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
