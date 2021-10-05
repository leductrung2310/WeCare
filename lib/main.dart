import 'package:flutter/material.dart';

import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/screen/fitness/fitness_screen.dart';
import 'package:wecare_flutter/screen/food/food_screen.dart';
import 'package:wecare_flutter/screen/home/home_screen.dart';
import 'package:wecare_flutter/screen/onboarding_screen/splash_screen.dart';
import 'package:wecare_flutter/screen/profile/profile_screen.dart';

void main() => runApp(const WeCare());

class WeCare extends StatelessWidget {
  const WeCare({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: getInitalRoute(),
      onGenerateRoute: (route) => getRoute(route),
    );
  }

  String getInitalRoute() => Routes.splash;

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
  //       home: RegisterUpdateInfoScreen(),
  //     ),
  //   );
  // }
}
