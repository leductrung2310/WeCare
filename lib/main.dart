import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/model/exercise_arguments.dart';

import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/screen/authentication/login/forget_password_screen.dart';
import 'package:wecare_flutter/screen/authentication/login/verify_email_screen.dart';
import 'package:wecare_flutter/screen/fitness/fitness_screen.dart';
import 'package:wecare_flutter/screen/fitness/introduce_screen.dart';
import 'package:wecare_flutter/screen/fitness/widget/abs.dart';
import 'package:wecare_flutter/screen/fitness/widget/week_goal.dart';
import 'package:wecare_flutter/screen/fitness/widget/workout_choices.dart';
import 'package:wecare_flutter/screen/food/food_screen.dart';
import 'package:wecare_flutter/screen/home/bmi/bmi_screen.dart';
import 'package:wecare_flutter/screen/home/home_screen.dart';
import 'package:wecare_flutter/screen/home/water/water_screen.dart';
import 'package:wecare_flutter/screen/main_screen.dart';
import 'package:wecare_flutter/screen/onboarding_screen/onboarding_screen.dart';
import 'package:wecare_flutter/screen/onboarding_screen/splash_screen.dart';
import 'package:wecare_flutter/screen/profile/profile_screen.dart';
import 'package:wecare_flutter/view_model/workout_tab_view_model.dart';

bool? seenOnboard;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //* Use this to make the status bar visible
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      //* Set background color for the status bar 
      // statusBarColor: Colors.transparent,
      //* Set the color brightness for icons of status bar
      statusBarIconBrightness: Brightness.light,
    ),
  );
  //to load UI for the first time
  SharedPreferences prefs = await SharedPreferences.getInstance();

  //? If the seenOnboard value equals to null then return false
  seenOnboard = prefs.getBool('seenOnboard') ?? false;
  runApp(const WeCare());
}

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

  String getInitalRoute() {
    //? if seenOnboard equals to true than return to sign up page
    return seenOnboard == true ? Routes.main : Routes.onboarding;
  }

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
        return buildRoute(const MainScreen(), settings: settings);
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
