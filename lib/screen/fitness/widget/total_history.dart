import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/view_model/exercise/history_workout_view_model.dart';

class TotalWorkout extends StatelessWidget {
  const TotalWorkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final historyWorkoutViewModel =
        Provider.of<HistoryWorkoutViewModel>(context);

    return SizedBox(
      height: sizeV * 13.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Totally",
            style: oTitle,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: sizeV,
                  ),
                  Text(
                    "${historyWorkoutViewModel.totalWorkouts}",
                    style: profileInfoText,
                  ),
                  Text(
                    "Workouts",
                    style: oSubtitle,
                  )
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: sizeV,
                  ),
                  Text(
                    historyWorkoutViewModel.formatWorkoutTime(),
                    style: profileInfoText,
                  ),
                  Text(
                    "Minutes",
                    style: oSubtitle,
                  )
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: sizeV,
                  ),
                  Text(
                    historyWorkoutViewModel.totalKcal.toStringAsFixed(2),
                    style: profileInfoText,
                  ),
                  Text(
                    "Kcal",
                    style: oSubtitle,
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 3,
            color: metalGreyColor,
          )
        ],
      ),
    );
  }
}
