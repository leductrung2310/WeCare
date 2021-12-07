import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/assets/custom_icons/custom_icon.dart';
import 'package:wecare_flutter/screen/home/home_screen.dart';
import 'package:wecare_flutter/screen/profile/profile_screen.dart';
import 'package:wecare_flutter/services/authentic_service.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/view_model/food/food_view_model.dart';
import 'package:wecare_flutter/view_model/exercise/history_workout_view_model.dart';
import 'package:wecare_flutter/view_model/home_vm/bmi_view_model.dart';
import 'package:wecare_flutter/view_model/home_vm/water_view_model.dart';
import 'package:wecare_flutter/view_model/notification_view_nodel.dart';
import 'fitness/fitness_screen.dart';
import 'food/food_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currenIndex = 0;
  final screens = const [
    HomeScreen(),
    FitnessScreen(),
    FoodScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    Provider.of<AuthenticService>(context, listen: false).getDataFromFirebase();
    Provider.of<FoodViewModel>(context, listen: false).setListRecipes();
    Provider.of<FoodViewModel>(context, listen: false).setListRecipesPopular();
    Provider.of<NotificationService>(context, listen: false).initialize();
    Provider.of<HistoryWorkoutViewModel>(context, listen: false)
        .getTotalWorkoutFromFirebase();
    Provider.of<HistoryWorkoutViewModel>(context, listen: false)
        .getHistoryWorkoutsFromFirebase(context);
    Provider.of<HistoryWorkoutViewModel>(context, listen: false)
        .getTotalWeeklyHistoryToFirestore(context);
    Provider.of<FoodViewModel>(context, listen: false)
        .getNutritionHistoryList(FirebaseAuth.instance.currentUser!.uid);
    Provider.of<HistoryWorkoutViewModel>(context, listen: false)
        .getWeekGoal(context);
    Provider.of<BMIHistoryViewModel>(context, listen: false)
        .getDataFromFirestore();
    Provider.of<WaterViewModel>(context, listen: false).getDataFromFirestore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider.of<AuthenticService>(context).isLoginHome
          ? screens[currenIndex]
          : Center(
              child: spinkit,
            ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            backgroundColor: whiteColor,
            indicatorColor: primaryColor,
            labelTextStyle: MaterialStateProperty.all(
              const TextStyle(
                  fontFamily: 'Poppins',
                  color: primaryColor,
                  fontWeight: FontWeight.w700),
            )),
        child: NavigationBar(
          height: 60,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          animationDuration: const Duration(seconds: 1),
          selectedIndex: currenIndex,
          onDestinationSelected: (index) => setState(() {
            currenIndex = index;
          }),
          destinations: const [
            NavigationDestination(
              icon: Icon(
                CustomIcons.home,
                color: Colors.grey,
              ),
              label: 'Home',
              selectedIcon: Icon(
                CustomIcons.home,
                color: whiteColor,
                size: 20,
              ),
            ),
            NavigationDestination(
              icon: Icon(
                CustomIcons.exercises,
                color: Colors.grey,
              ),
              label: 'Fitness',
              selectedIcon: Icon(
                CustomIcons.exercises,
                color: whiteColor,
                size: 20,
              ),
            ),
            NavigationDestination(
              icon: Icon(
                CustomIcons.food,
                color: Colors.grey,
              ),
              label: 'Food',
              selectedIcon: Icon(
                CustomIcons.food,
                color: whiteColor,
                size: 20,
              ),
            ),
            NavigationDestination(
              icon: Icon(
                CustomIcons.profile,
                color: Colors.grey,
              ),
              label: 'Profile',
              selectedIcon: Icon(
                CustomIcons.profile,
                color: whiteColor,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
