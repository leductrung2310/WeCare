import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/model/wecare_user.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/screen/fitness/introduce_screen.dart';
import 'package:wecare_flutter/screen/fitness/widget/female/workout_choices_female.dart';
import 'package:wecare_flutter/screen/fitness/widget/male/arms.dart';
import 'package:wecare_flutter/screen/fitness/widget/week_goal.dart';
import 'package:wecare_flutter/screen/fitness/widget/male/workout_choices.dart';
import 'package:wecare_flutter/services/authentic_service.dart';

class FitnessScreen extends StatelessWidget {
  const FitnessScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final currentUser = FirebaseAuth.instance.currentUser;

    final auth = Provider.of<AuthenticService>(context);

    String name = "Unknow User";
    if (currentUser!.displayName != null) {
      name = currentUser.displayName!;
    } else if (auth.loggedInUser.name != null) {
      name = auth.loggedInUser.name!;
    }

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
                    padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
                    child: Text(
                      "Let's workout, \n$name",
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
                    padding: const EdgeInsets.fromLTRB(16, 24, 0, 8),
                    child: Text(
                      'Select workout',
                      style: oBlackTitle,
                    ),
                  ),
                  auth.loggedInUser.gender == true
                      ? const WorkoutChoice()
                      : const FemaleChoices(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
