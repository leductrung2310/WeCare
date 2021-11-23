import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wecare_flutter/model/exercise/exercise.dart';

import 'package:wecare_flutter/model/exercise/exercise_arguments.dart';
import 'package:wecare_flutter/model/wecare_user.dart';
import 'package:wecare_flutter/screen/fitness/take_rest_screen.dart';

import 'package:wecare_flutter/screen/food/food__detail_screen.dart';
import 'package:wecare_flutter/screen/fitness/finish_workout_screen.dart';
import 'package:wecare_flutter/screen/fitness/workout_screen.dart';
import 'package:wecare_flutter/screen/home/water/water_statistic_screen.dart';

import 'package:wecare_flutter/screen/profile/change_password_success_screen.dart';
import 'package:wecare_flutter/screen/profile/profile_information_screen.dart';
import 'package:wecare_flutter/screen/home/sleep/sleep_screen.dart';
import 'package:wecare_flutter/services/authentic_service.dart';
import 'package:wecare_flutter/services/google_service.dart';

import 'package:wecare_flutter/view_model/change_password_view_model.dart';
import 'package:wecare_flutter/view_model/exercise/exercise_view_model.dart';
import 'package:wecare_flutter/view_model/food_view_model.dart';
import 'package:wecare_flutter/view_model/register_view_model.dart';
import 'package:wecare_flutter/view_model/setting_view_model.dart';
import 'package:wecare_flutter/view_model/sleep_view_model.dart';
import 'package:wecare_flutter/view_model/exercise/workout_tab_view_model.dart';

import 'package:wecare_flutter/screen/main_screen.dart';
import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/screen/authentication/login/home_view_mode.dart';
import 'package:wecare_flutter/screen/authentication/login/login_screen.dart';
import 'package:wecare_flutter/screen/authentication/register/register_screen.dart';
import 'package:wecare_flutter/screen/authentication/register/register_update_infor_screen.dart';
import 'package:wecare_flutter/screen/authentication/login/forget_password_screen.dart';
import 'package:wecare_flutter/screen/authentication/login/verify_email_screen.dart';

import 'package:wecare_flutter/screen/fitness/fitness_screen.dart';
import 'package:wecare_flutter/screen/fitness/introduce_screen.dart';
import 'package:wecare_flutter/screen/fitness/widget/male/abs.dart';
import 'package:wecare_flutter/screen/fitness/widget/week_goal.dart';
import 'package:wecare_flutter/screen/fitness/widget/male/workout_choices.dart';

import 'package:wecare_flutter/screen/food/food_screen.dart';

import 'package:wecare_flutter/screen/home/bmi/bmi_screen.dart';
import 'package:wecare_flutter/screen/home/home_screen.dart';
import 'package:wecare_flutter/screen/home/water/water_screen.dart';

import 'package:wecare_flutter/screen/onboarding_screen/onboarding_screen.dart';

import 'package:wecare_flutter/screen/profile/change_password_screen.dart';
import 'package:wecare_flutter/screen/profile/profile_screen.dart';
import 'package:wecare_flutter/screen/profile/setting_screen.dart';

bool? seenOnboard;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ),
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();

  seenOnboard = prefs.getBool('seenOnboard') ?? false;
  runApp(const WeCare());
}

class WeCare extends StatelessWidget {
  const WeCare({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginViewModel>(
            create: (context) => LoginViewModel()),
        ChangeNotifierProvider<RegisterViewModel>(
            create: (context) => RegisterViewModel()),
        ChangeNotifierProvider<SettingViewModel>(
            create: (context) => SettingViewModel()),
        ChangeNotifierProvider<ChangePasswordViewModel>(
            create: (context) => ChangePasswordViewModel()),
        ChangeNotifierProvider<WorkoutTabViewModel>(
            create: (context) => WorkoutTabViewModel()),
        ChangeNotifierProvider<FoodViewModel>(
            create: (context) => FoodViewModel()),
        ChangeNotifierProvider<SleepViewModel>(
            create: (context) => SleepViewModel()),
        ChangeNotifierProvider<WorkoutViewModel>(
            create: (context) => WorkoutViewModel()),
        ChangeNotifierProvider<AuthenticService>(
            create: (context) => AuthenticService()),
        ChangeNotifierProvider<GoogleSignInProvider>(
            create: (context) => GoogleSignInProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.login,
        onGenerateRoute: (route) => getRoute(route),
      ),
    );
  }

  String getInitalRoute() {
    return seenOnboard == true ? Routes.login : Routes.onboarding;
  }

  Route? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onboarding:
        return buildRoute(const OnBoardingPage(), settings: settings);
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
      case Routes.login:
        return buildRoute(const LoginScreen(), settings: settings);
      case Routes.register:
        return buildRoute(const RegisterScreen(), settings: settings);
      case Routes.forgetpassword:
        return buildRoute(const ForgetPasswordScreen(), settings: settings);
      case Routes.registerUpdateInfo:
        return buildRoute(const RegisterUpdateInfoScreen(), settings: settings);
      case Routes.settingScreen:
        return buildRoute(const SettingScreen(), settings: settings);
      case Routes.changePasswordScreen:
        return buildRoute(const ChangePasswordScreen(), settings: settings);
      case Routes.foodDetailScreen:
        return buildRoute(const FoodDetailScreene(), settings: settings);
      case Routes.workouting:
        List<Exercise> arg = settings.arguments as List<Exercise>;
        return buildRoute(Workouting(arguments: arg), settings: settings);
      case Routes.finishworout:
        return buildRoute(const FinishWorkout(), settings: settings);
      case Routes.introworkout:
        ExerciseArguments args = settings.arguments as ExerciseArguments;
        return buildRoute(IntroWorkouts(arguments: args), settings: settings);
      case Routes.bmiScreen:
        return buildRoute(const BMIRatioScreen(), settings: settings);
      case Routes.waterScreen:
        return buildRoute(const WaterScreen(), settings: settings);
      case Routes.changePasswordSuccessScreen:
        return buildRoute(const ChangePasswordSuccessScreen(),
            settings: settings);
      case Routes.profileInformationScreen:
        return buildRoute(const ProfileInformationScreen(), settings: settings);
      case Routes.sleepScreen:
        return buildRoute(const SleepScreen(), settings: settings);
      case Routes.takerest:
        List<Exercise> arg = settings.arguments as List<Exercise>;
        return buildRoute(RestScreen(arguments: arg), settings: settings);
      case Routes.waterScreenStatistic:
        return buildRoute(const WaterStatisticScreen(), settings: settings);

      default:
        null;
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
