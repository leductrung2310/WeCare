import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/screen/authentication/login/home_view_mode.dart';
import 'package:wecare_flutter/screen/authentication/login/login_screen.dart';
import 'package:wecare_flutter/screen/authentication/register/register_screen.dart';
import 'package:wecare_flutter/screen/authentication/register/register_update_infor_screen.dart';
import 'package:wecare_flutter/screen/fitness/fitness_screen.dart';
import 'package:wecare_flutter/screen/food/food_screen.dart';
import 'package:wecare_flutter/screen/home/home_screen.dart';
import 'package:wecare_flutter/screen/onboarding_screen/splash_screen.dart';
import 'package:wecare_flutter/screen/profile/profile_screen.dart';
import 'package:wecare_flutter/screen/profile/setting_screen.dart';
import 'package:wecare_flutter/view_model/register_view_model.dart';

void main() => runApp(const WeCare());

class WeCare extends StatelessWidget {
  const WeCare({Key? key}) : super(key: key);
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     initialRoute: getInitalRoute(),
  //     onGenerateRoute: (route) => getRoute(route),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>(
            create: (context) => LoginViewModel()),
        ChangeNotifierProvider<RegisterViewModel>(
            create: (context) => RegisterViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: getInitalRoute(),
        onGenerateRoute: (route) => getRoute(route),
      ),
    );
  }

  String getInitalRoute() => Routes.main;

  Route getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return buildRoute(const HomeScreen(), settings: settings);
      case Routes.fitness:
        return buildRoute(const FitnessScreen(), settings: settings);
      case Routes.food:
        return buildRoute(const FoodScreen(), settings: settings);
      case Routes.profile:
        return buildRoute(const ProfileScreen(), settings: settings);
      case Routes.splash:
        return buildRoute(const SplashScreen(), settings: settings);
      case Routes.login:
        return buildRoute(const LoginScreen(), settings: settings);
      case Routes.register:
        return buildRoute(const RegisterScreen(), settings: settings);
      case Routes.registerUpdateInfo:
        return buildRoute(const RegisterUpdateInfoScreen(), settings: settings);
      case Routes.settingScreen:
        return buildRoute(const SettingScreen(), settings: settings);

      default:
        return buildRoute(const SplashScreen(), settings: settings);
    }
  }

  MaterialPageRoute buildRoute(Widget child,
      {required RouteSettings settings}) {
    return MaterialPageRoute(
        settings: settings, builder: (BuildContext context) => child);
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
  //       home: LoginScreen(),
  //     ),
  //   );
  // }
}
