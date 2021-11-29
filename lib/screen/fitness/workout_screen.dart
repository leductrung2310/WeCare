import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/model/exercise/exercise.dart';
import 'package:wecare_flutter/routes.dart';
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
                        onPressed: () {},
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
                            workoutViewModel2.restTime =
                                arguments[workoutViewModel.indexWorkout]
                                    .restTime;
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
