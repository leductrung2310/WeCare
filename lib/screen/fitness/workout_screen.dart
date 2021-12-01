import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/model/exercise/exercise.dart';
import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/screen/fitness/widget/custom_btn.dart';
import 'package:wecare_flutter/view_model/exercise/exercise_view_model.dart';
import 'package:wecare_flutter/view_model/exercise/history_workout_view_model.dart';
import 'package:wecare_flutter/view_model/exercise/workout_tab_view_model.dart';

import '../../constants/constants.dart';

class Workouting extends StatelessWidget {
  final List<Exercise> arguments;

  const Workouting({Key? key, required this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final workoutViewModel = Provider.of<WorkoutViewModel>(context);
    final workoutViewModel2 =
        Provider.of<WorkoutViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                arguments[workoutViewModel.indexWorkout].gif,
                height: sizeV * 60,
                width: sizeH * 100,
              ),
              Text(
                arguments[workoutViewModel.indexWorkout].name,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: SizeConfig.blockSizeH! * 8,
                  color: Colors.black.withOpacity(0.85),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                arguments[workoutViewModel.indexWorkout].reps,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: SizeConfig.blockSizeH! * 8,
                  color: Colors.black.withOpacity(0.85),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: sizeV * 3,
              ),
              Container(
                height: sizeV * 13,
                width: sizeH * 70,
                decoration: BoxDecoration(
                  color: grey1,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 2,
                    color: metalGreyColor,
                  ),
                ),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 60,
                        onPressed: () {
                          if (workoutViewModel.indexWorkout == 0) {
                          } else {
                            workoutViewModel.setPreviousIndexWorkout();
                          }
                        },
                        icon: const Icon(
                          Icons.skip_previous,
                          color: primaryColor,
                        ),
                      ),
                      IconButton(
                        iconSize: 60,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  pauseDialog(context, sizeV * 50, sizeH * 80));
                          //workoutViewModel2.getTimer.cancel();
                        },
                        icon: const Icon(
                          Icons.pause_circle,
                          color: primaryColor,
                        ),
                      ),
                      IconButton(
                        iconSize: 60,
                        onPressed: () {
                          if (workoutViewModel.indexWorkout ==
                              (arguments.length - 1)) {
                            Navigator.pushNamed(context, Routes.finishworout);
                            Provider.of<WorkoutTabViewModel>(context,
                                    listen: false)
                                .confettiController
                                .play();
                            workoutViewModel2.getTimer.cancel();
                          } else {
                            workoutViewModel2.setIndexWorkout();
                            final arg = arguments;
                            Navigator.pushNamed(context, Routes.takerest,
                                arguments: arg);
                          }
                        },
                        icon: const Icon(
                          Icons.skip_next,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Dialog pauseDialog(BuildContext context, double height, double width) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primaryColor.withOpacity(0.9),
      ),
      height: height,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              "PAUSE",
              style: TextStyle(
                fontSize: 32,
                color: whiteColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          CustomBTN(
            width: 260,
            height: 70,
            name: "RESTART THIS EXERCISE",
            textColor: whiteColor,
            fontWeight: FontWeight.w700,
            colorBorder: whiteColor,
            color: primaryColor,
            widthBorder: 5,
            radius: 12,
            onPressed: () {
              Provider.of<WorkoutViewModel>(context, listen: false)
                  .indexWorkout = 0;
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(
            height: 15,
          ),
          CustomBTN(
            height: 70,
            width: 260,
            name: "QUIT",
            textColor: whiteColor,
            fontWeight: FontWeight.w700,
            colorBorder: whiteColor,
            color: primaryColor,
            widthBorder: 5,
            radius: 12,
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.main);
            },
          ),
          const SizedBox(
            height: 15,
          ),
          CustomBTN(
            height: 70,
            width: 260,
            name: "RESUME",
            textColor: whiteColor,
            fontWeight: FontWeight.w700,
            colorBorder: whiteColor,
            color: primaryColor,
            widthBorder: 5,
            radius: 12,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    ),
  );
}
