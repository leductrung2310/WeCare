import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/screen/home/widgets/tools/appbar.dart';
import 'package:wecare_flutter/screen/onboarding_screen/widgets/custom_button.dart';
import 'package:wecare_flutter/screen/home/water/widgets/water_painter.dart';

class WaterScreen extends StatefulWidget {
  const WaterScreen({Key? key}) : super(key: key);

  @override
  _WaterScreenState createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen>
    with TickerProviderStateMixin {
  late AnimationController firstController;
  late Animation firstAnimation;

  late AnimationController secondController;
  late Animation secondAnimation;

  late AnimationController thirdController;
  late Animation thirdAnimation;

  late AnimationController fourthController;
  late Animation fourthAnimation;

  @override
  //* Should initialize the animation as well as its
  //* controller in the initState method
  void initState() {
    super.initState();

    firstController = AnimationController(
      vsync: this, //? Why pass "this" here
      duration: const Duration(milliseconds: 1500),
    );
    firstAnimation = Tween<double>(begin: 1.9, end: 2.1).animate(
      CurvedAnimation(parent: firstController, curve: Curves.easeInOut)
        ..addListener(() {
          setState(() {});
        })
        ..addStatusListener(
          (status) {
            if (status == AnimationStatus.completed) {
              firstController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              firstController.forward();
            }
          },
        ),
    );

    secondController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    secondAnimation = Tween<double>(begin: 1.8, end: 2.4).animate(
        CurvedAnimation(parent: secondController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          secondController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          secondController.forward();
        }
      });

    thirdController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    thirdAnimation = Tween<double>(begin: 1.8, end: 2.4).animate(
        CurvedAnimation(parent: thirdController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          thirdController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          thirdController.forward();
        }
      });

    fourthController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    fourthAnimation = Tween<double>(begin: 1.9, end: 2.1).animate(
        CurvedAnimation(parent: fourthController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          fourthController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          fourthController.forward();
        }
      });

    Timer(const Duration(seconds: 2), () {
      firstController.forward();
    });

    Timer(const Duration(milliseconds: 1600), () {
      secondController.forward();
    });

    Timer(const Duration(milliseconds: 800), () {
      thirdController.forward();
    });

    fourthController.forward();
  }

  @override
  void dispose() {
    firstController.dispose();
    secondController.dispose();
    thirdController.dispose();
    fourthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    IconButton iconButton = IconButton(
      onPressed: () {
        Navigator.pushNamed(context, Routes.waterScreenStatistic);
      },
      icon: const Icon(
        Icons.timeline,
        color: waterColor,
      ),
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: customAppBar(
          context,
          waterColor,
          'Water',
          iconButton,
        ),
        body: Stack(
          children: [
            Positioned.fill(
              top: sizeV * 10,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  '1290 ml',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: sizeV * 8,
                    fontWeight: FontWeight.w600,
                    color: lightBlack,
                  ),
                ),
              ),
            ),
            Positioned(
              top: sizeV * 21,
              child: Image.asset(
                'assets/images/home/water/drink.png',
                height: sizeV * 48,
              ),
            ),
            CustomPaint(
              painter: WaterPainter(
                firstAnimation.value,
                secondAnimation.value,
                thirdAnimation.value,
                fourthAnimation.value,
              ),
              child: SizedBox(
                height: sizeV * 100,
                width: sizeH * 100,
              ),
            ),
            Positioned.fill(
              top: sizeV * 20,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Remaining: 610ml',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: sizeV * 2.5,
                    fontWeight: FontWeight.w500,
                    color: waterColor,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              bottom: sizeV * 17,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Next reminder in: 3hrs',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: sizeV * 2.5,
                    color: lightBlack,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              bottom: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: CustomTextBtn(
                  name: 'Drink now (350ml)',
                  onPressed: () {},
                  color: waterColor,
                  textColor: whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
