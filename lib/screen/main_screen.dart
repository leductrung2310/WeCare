import 'package:flutter/material.dart';
import 'package:wecare_flutter/assets/custom_icons/custom_icon.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/screen/home/home_screen.dart';
import 'package:wecare_flutter/screen/profile/profile_screen.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currenIndex],
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
