import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/model/exercise_arguments.dart';

import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/screen/fitness/fitness_screen.dart';
import 'package:wecare_flutter/screen/fitness/introduce_screen.dart';
import 'package:wecare_flutter/screen/fitness/widget/abs.dart';
import 'package:wecare_flutter/screen/fitness/widget/week_goal.dart';
import 'package:wecare_flutter/screen/fitness/widget/workout_choices.dart';
import 'package:wecare_flutter/screen/food/food_screen.dart';
import 'package:wecare_flutter/screen/home/home_screen.dart';
import 'package:wecare_flutter/screen/main_screen.dart';
import 'package:wecare_flutter/screen/onboarding_screen/splash_screen.dart';
import 'package:wecare_flutter/screen/profile/profile_screen.dart';
import 'package:wecare_flutter/view_model/workout_tab_view_model.dart';

void main() => runApp(const WeCare());

class WeCare extends StatelessWidget {
  const WeCare({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WorkoutTabViewModel>(
            create: (context) => WorkoutTabViewModel()),
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
      case Routes.main:
        return buildRoute(const MainScreen(), settings: settings);
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
      case Routes.introworkout:
        ExerciseArguments args = settings.arguments as ExerciseArguments;
        return buildRoute(IntroWorkouts(arguments: args), settings: settings);

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
