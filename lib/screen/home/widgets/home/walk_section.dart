import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_icon/svg_icon.dart';
import 'package:wecare_flutter/view_model/exercise/exercise_view_model.dart';
import 'package:wecare_flutter/view_model/exercise/history_workout_view_model.dart';

import '../../../../constants/constants.dart';
import '../../../../routes.dart';

class StepCountPart extends StatelessWidget {
  const StepCountPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final historyWorkoutViewModel =
        Provider.of<HistoryWorkoutViewModel>(context);
    final historyWorkoutViewModel2 =
        Provider.of<HistoryWorkoutViewModel>(context, listen: false);

    final workoutViewModel = Provider.of<WorkoutViewModel>(context);

    return InkWell(
      splashColor: grey1,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: sizeV * 15.5,
        width: sizeH * 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: lightBlack1, width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            WalkItem(
              assetName: 'assets/images/home/walk/dumbbell.svg',
              index: historyWorkoutViewModel.totalDailyWorkout.toString(),
              name: 'Workouts',
              color: stepColor,
              height: sizeV * 5,
              width: sizeH * 7.5,
              space: 0,
            ),
            SizedBox(width: sizeH * 1.5),
            WalkItem(
              assetName: 'assets/images/home/walk/time-2624.svg',
              index: workoutViewModel
                  .formatWorkoutTime(historyWorkoutViewModel.totalDailyMinute),
              name: 'Minutes',
              color: distanceColor,
            ),
            SizedBox(width: sizeH * 1.5),
            WalkItem(
              assetName: 'assets/images/home/walk/calories.svg',
              index: historyWorkoutViewModel.totalDailyKcal.toStringAsFixed(2),
              name: 'Kcal',
              color: speedColor,
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(Routes.fitnessHistoryScreen);
        historyWorkoutViewModel2.getHistoryWorkoutsFromFirebase(context, "");
        historyWorkoutViewModel2.getTotalWeeklyHistoryToFirestore(context, "");
        historyWorkoutViewModel2.getHistoryWorkoutsChartFromFireStore(
            context, "");
      },
    );
  }
}

class WalkItem extends StatelessWidget {
  const WalkItem({
    Key? key,
    required this.assetName,
    required this.index,
    required this.name,
    required this.color,
    this.height,
    this.width,
    this.space,
  }) : super(key: key);
  final String assetName;
  final String name;
  final String index;
  final Color color;
  final double? height;
  final double? width;
  final double? space;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgIcon(
          assetName,
          height: height ?? sizeV * 4.5,
          width: width ?? sizeH * 6,
          color: color,
        ),
        SizedBox(height: space ?? sizeV * 0.7),
        SizedBox(
          height: sizeV * 3.5,
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: sizeV * 3,
                fontWeight: FontWeight.w600,
                color: lightBlack,
              ),
              children: [
                TextSpan(text: index),
              ],
            ),
          ),
        ),
        Text(
          name,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: sizeV * 2.3,
            fontWeight: FontWeight.w600,
            color: lightBlack1,
          ),
        ),
      ],
    );
  }
}
