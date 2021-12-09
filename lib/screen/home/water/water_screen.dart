import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/screen/home/widgets/tools/appbar.dart';
import 'package:wecare_flutter/screen/onboarding_screen/widgets/custom_button.dart';
import 'package:wecare_flutter/screen/home/water/widgets/water_painter.dart';
import 'package:wecare_flutter/services/authentic_service.dart';
import 'package:wecare_flutter/view_model/home_vm/water_view_model.dart';

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

    WaterViewModel waterViewModel = Provider.of<WaterViewModel>(context);
    double remained =
        Provider.of<AuthenticService>(context).calculateDesiredAmount(context) -
            waterViewModel.waterData.waterIndex;
    AuthenticService authenticService = Provider.of<AuthenticService>(context);

    if (remained < 0) {
      remained = 0;
    }
    String index =
        (waterViewModel.waterData.waterIndex * 1000).toStringAsFixed(0);

    IconButton iconButton = IconButton(
      onPressed: () async {
        Navigator.pushNamed(context, Routes.waterScreenStatistic);
        await waterViewModel.getQuerySnapshot(0);
        waterViewModel.calculateAverage(context);
        await Provider.of<WaterViewModel>(context, listen: false).pushDataToFirestore2(context);
        // waterViewModel.setIsLoading = false;
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
          fit: StackFit.expand,
          children: [
            Positioned(
              bottom: 0,
              child: CustomPaint(
                painter: WaterPainter(
                  firstAnimation.value,
                  secondAnimation.value,
                  thirdAnimation.value,
                  fourthAnimation.value,
                ),
                child: AnimatedContainer(
                  duration: const Duration(seconds: 2),
                  height: waterViewModel.getCurrentIndex >=
                          authenticService.getDesiredAmount
                      ? sizeV * 160
                      : sizeV *
                          (waterViewModel.getCurrentIndex /
                              authenticService.getDesiredAmount) *
                          150,
                  width: sizeH * 100,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$index ml',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: sizeV * 7,
                    fontWeight: FontWeight.w600,
                    color: lightBlack,
                  ),
                ),
                Text(
                  'Remaining: ${(remained * 1000).toStringAsFixed(0)} ml',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: sizeV * 2.5,
                    fontWeight: FontWeight.w500,
                    color: waterColor,
                  ),
                ),
                Image.asset(
                  'assets/images/home/water/drink.png',
                  height: sizeV * 40,
                ),
                SizedBox(height: sizeV * 2),
                Text(
                  'Next reminder in: 3hrs',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: sizeV * 2.5,
                    color: lightBlack,
                  ),
                ),
                SizedBox(height: sizeV * 1.5),
                Slider(
                    min: 0,
                    max: 0.6,
                    divisions: 6,
                    activeColor: waterColor,
                    label:
                        '${((waterViewModel.getDrinkAmount) * 1000).round()} ml',
                    value: waterViewModel.getDrinkAmount,
                    onChanged: (double value) {
                      waterViewModel.setDrinkAmount = value;
                    }),
                SizedBox(height: sizeV * 2),
                CustomTextBtn(
                  name:
                      'Drink now (${((waterViewModel.getDrinkAmount) * 1000).round()}ml)',
                  onPressed: () async {
                    waterViewModel
                        .calculateCurrentIndex(waterViewModel.getDrinkAmount);
                    waterViewModel.calculateDrinkTimes();
                    waterViewModel.pushDataToFirestore(context);
                    await waterViewModel.getQuerySnapshot(0);
                    // waterViewModel.setIsLoading = false;
                  },
                  color: waterColor,
                  textColor: whiteColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
