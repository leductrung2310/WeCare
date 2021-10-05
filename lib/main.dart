import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/screen/authentication/login/home_view_mode.dart';
import 'package:wecare_flutter/screen/authentication/login/login_screen.dart';
import 'package:wecare_flutter/screen/authentication/register/register_screen.dart';
import 'package:wecare_flutter/screen/authentication/register/register_update_infor_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins",
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return ChangeNotifierProvider(
  //     create: (context) => LoginViewModel(),
  //     child: MaterialApp(
  //       theme: ThemeData(
  //         fontFamily: "Poppins",
  //         primaryColor: Color(0xFF91c788),
  //       ),
  //       debugShowCheckedModeBanner: false,
  //       home: RegisterUpdateInfoScreen(),
  //     ),
  //   );
  // }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Text("hello word"),
      backgroundColor: accentColor,
    ));
  }
}
