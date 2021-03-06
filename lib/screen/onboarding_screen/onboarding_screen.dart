import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/main.dart';
import "package:wecare_flutter/model/onboard_data.dart";
import 'package:wecare_flutter/screen/authentication/login/login_screen.dart';
import 'package:wecare_flutter/screen/onboarding_screen/widgets/custom_button.dart';
import 'package:wecare_flutter/screen/onboarding_screen/widgets/nav_button.dart';
import 'package:wecare_flutter/screen/onboarding_screen/widgets/nav_textbutton.dart';


class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  AnimatedContainer dotIndicator(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: 12,
      width: 12,
      margin: const EdgeInsets.only(right: 7),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: currentPage == index ? primaryColor : metalGreyColor,
      ),
    );
  }

  List<Widget> _dotIndicatorList() {
    List<Widget> widgets = [];
    for (int index = 0; index < onboardingContents.length; index++) {
      widgets.add(dotIndicator(index));
    }
    return widgets;
  }

  Future setSeenOnboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //? Set seenOnboard value to true when running onboard page for first time
    seenOnboard = await prefs.setBool('seenOnboard', true);
  }

  @override
  void initState() {
    super.initState();
    setSeenOnboard();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: sizeV * 6),
            Image.asset(
              'assets/images/logos/logo.png',
              height: sizeV * 6,
              width: sizeH * 50,
            ),
            SizedBox(height: sizeV * 6),
            Expanded(
              flex: 4,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: onboardingContents.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    Image.asset(
                      onboardingContents[index].image,
                      height: sizeV * 40,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: sizeV * 4),
                    Text(
                      onboardingContents[index].title,
                      style: oTitle,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      onboardingContents[index].subtitle,
                      style: oSubtitle,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: sizeV * 4),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: currentPage == onboardingContents.length - 1
                  ? CustomTextBtn(
                      name: 'Get started',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      color: primaryColor,
                      textColor: whiteColor,
                    )
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _dotIndicatorList(),
                        ),
                        SizedBox(height: sizeV * 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OnboardingNavTextBtn(
                              text: 'Skip',
                              onPressed: () {
                                currentPage = onboardingContents.length - 1;
                                _pageController.animateToPage(
                                  currentPage,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.bounceInOut,
                                );
                              },
                            ),
                            SizedBox(width: sizeH * 11),
                            OnboardingNavBtn(onPressed: () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            })
                          ],
                        ),
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }
}
