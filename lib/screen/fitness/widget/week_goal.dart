import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/view_model/exercise/history_workout_view_model.dart';

class WeekGoal extends StatelessWidget {
  const WeekGoal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    DateTime currentTime = DateTime.now();
    final historyWorkoutViewModel =
        Provider.of<HistoryWorkoutViewModel>(context, listen: false);

    int getDay(int x) {
      return currentTime.subtract(Duration(days: currentTime.weekday - x)).day;
    }

    return InkWell(
      onTap: () => {
        Navigator.of(context).pushNamed(Routes.fitnessHistoryScreen),
        Provider.of<HistoryWorkoutViewModel>(context, listen: false)
            .getHistoryWorkoutsFromFirebase(context, ""),
        Provider.of<HistoryWorkoutViewModel>(context, listen: false)
            .getTotalWeeklyHistoryToFirestore(context, ""),
        Provider.of<HistoryWorkoutViewModel>(context, listen: false)
            .getHistoryWorkoutsChartFromFireStore(context, ""),
      },
      child: Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: metalGreyColor,
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // change position of shadow
            )
          ],
        ),
        height: sizeV * 15,
        width: sizeH * 95,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                  child: Text(
                    'WEEK GOAL',
                    style: oBlackTitle,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                historyWorkoutViewModel.checkWorkouted(getDay(1))
                    ? const CustomeDate(text: 0)
                    : CustomeDate(text: getDay(1)),
                historyWorkoutViewModel.checkWorkouted(getDay(2))
                    ? const CustomeDate(text: 0)
                    : CustomeDate(text: getDay(2)),
                historyWorkoutViewModel.checkWorkouted(getDay(3))
                    ? const CustomeDate(text: 0)
                    : CustomeDate(text: getDay(3)),
                historyWorkoutViewModel.checkWorkouted(getDay(4))
                    ? const CustomeDate(text: 0)
                    : CustomeDate(text: getDay(4)),
                historyWorkoutViewModel.checkWorkouted(getDay(5))
                    ? const CustomeDate(text: 0)
                    : CustomeDate(text: getDay(5)),
                historyWorkoutViewModel.checkWorkouted(getDay(6))
                    ? const CustomeDate(text: 0)
                    : CustomeDate(text: getDay(6)),
                historyWorkoutViewModel.checkWorkouted(getDay(7))
                    ? const CustomeDate(text: 0)
                    : CustomeDate(text: getDay(7)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomeDate extends StatelessWidget {
  final int text;
  const CustomeDate({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return text != 0
        ? Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: grey1,
              shape: BoxShape.circle,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "$text",
                style: profileInfoHintText,
              ),
            ),
          )
        : Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.check,
                color: whiteColor,
              ),
            ),
          );
  }
}
