import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/screen/fitness/introduce_screen.dart';
import 'package:wecare_flutter/screen/fitness/widget/female/workout_choices_female.dart';
import 'package:wecare_flutter/screen/fitness/widget/male/arms.dart';
import 'package:wecare_flutter/screen/fitness/widget/week_goal.dart';
import 'package:wecare_flutter/screen/fitness/widget/male/workout_choices.dart';

class FitnessScreen extends StatefulWidget {
  const FitnessScreen({Key? key}) : super(key: key);

  @override
  _FitnessScreenState createState() => _FitnessScreenState();
}

class _FitnessScreenState extends State<FitnessScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Scaffold(
      backgroundColor: grey1,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: sizeV * 27.5,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [
                    primaryColor,
                    Colors.green.shade300,
                  ])),
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                    child: Text(
                      "Let's workout, \nJohn Wick",
                      style: oWhiteTitle,
                    ),
                  ),
                  SizedBox(
                    height: sizeV * 2,
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: WeekGoal(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Select workout',
                      style: oBlackTitle,
                    ),
                  ),
                  const WorkoutChoice(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
