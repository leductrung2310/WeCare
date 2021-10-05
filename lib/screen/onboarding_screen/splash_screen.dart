import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: primaryColor,
      duration: 1000,
      splash: Image.asset(
        'assets/images/logos/vector.png',
        height: 62,
        width: 293,
      ),
      splashTransition: SplashTransition.fadeTransition,
      nextScreen: const OnBoardingPage(),
    );
  }
}
