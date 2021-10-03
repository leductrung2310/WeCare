import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/screen/fitness/fitness_screen.dart';
import 'package:wecare_flutter/screen/food/food_screen.dart';
import 'package:wecare_flutter/screen/home/home_screen.dart';
import 'package:wecare_flutter/screen/main_screen.dart';
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

      default:
        return buildRoute(const MainScreen(), settings: settings);
    }
  }

  MaterialPageRoute buildRoute(Widget child,
      {required RouteSettings settings}) {
    return MaterialPageRoute(
        settings: settings, builder: (BuildContext context) => child);
  }
}
