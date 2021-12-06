import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/model/exercise/history_workouts_day.dart';
import 'package:wecare_flutter/screen/fitness/widget/fitness_bar_titles.dart';
import 'package:wecare_flutter/screen/fitness/widget/total_history.dart';
import 'package:wecare_flutter/screen/food/food_screen.dart';
import 'package:wecare_flutter/screen/home/water/widgets/animated_chart.dart';
import 'package:wecare_flutter/screen/home/widgets/tools/appbar.dart';
import 'package:wecare_flutter/view_model/exercise/exercise_view_model.dart';
import 'package:wecare_flutter/view_model/exercise/history_workout_view_model.dart';
import 'package:wecare_flutter/view_model/home_vm/weekly_calendar_viewmodel.dart';

class FitnessHistoryScreen extends StatelessWidget {
  const FitnessHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final workoutViewModel =
        Provider.of<WorkoutViewModel>(context, listen: false);
    final historyWorkoutViewModel =
        Provider.of<HistoryWorkoutViewModel>(context);

    Color grey = Colors.grey;

    SizedBox historyWorkoutItem(HistoryWorkoutDay historyWorkoutDay) {
      return SizedBox(
        height: sizeV * 9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: SizedBox(
                    width: sizeH * 50,
                    child: Text(
                      historyWorkoutDay.workouts!,
                      style: TextStyle(
                        color: accentColor,
                        fontSize: sizeV * 2.1,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.timer_outlined,
                  size: sizeV * 1.8,
                  color: grey,
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  workoutViewModel
                      .formatWorkoutTime(historyWorkoutDay.minutes!),
                  style: TextStyle(
                    color: grey,
                    fontSize: sizeV * 1.8,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 0, 0),
                  child: SizedBox(
                    width: sizeH * 50,
                    child: Text(
                      DateFormat.yMMMd('en_US')
                          .add_jm()
                          .format(historyWorkoutDay.time!),
                      style: TextStyle(
                        color: grey,
                        fontSize: sizeV * 1.8,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.bolt,
                  size: sizeV * 2,
                  color: grey,
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  '${historyWorkoutDay.kcal!.toStringAsFixed(2)} kcal',
                  style: TextStyle(
                    color: grey,
                    fontSize: sizeV * 1.8,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            Container(height: 2, color: metalGreyColor),
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(
            context, primaryColor, 'Workout', const SizedBox.shrink()),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: sizeV),
              const TotalWorkout(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Weekly",
                  style: oTitle,
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: ChangeNotifierProvider(
                  create: (context) => WeeklyCalendarVM(),
                  child: AnimatedChart(
                    onPressed1: () {
                      historyWorkoutViewModel.listHistory = [];
                      historyWorkoutViewModel.changeCalendar(true);
                      String subDocument =
                          historyWorkoutViewModel.getSubDocument(context);
                      historyWorkoutViewModel.getHistoryWorkoutsFromFirebase(
                          context, subDocument);
                      print(historyWorkoutViewModel.listHistory);
                    },
                    onPressed2: () {
                      historyWorkoutViewModel.listHistory = [];
                      historyWorkoutViewModel.changeCalendar(false);
                      String subDocument =
                          historyWorkoutViewModel.getSubDocument(context);
                      historyWorkoutViewModel.getHistoryWorkoutsFromFirebase(
                          context, subDocument);
                    },
                    color: primaryColor,
                    barWidth: sizeH * 4,
                    width: sizeH * 90,
                    height: sizeV * 45,
                    barChartGroupData: FitnessBarData.fitnessBarChartList,
                    flTitlesData: FlTitlesData(
                      bottomTitles: FitnessBarTitles.getBottomTitles(),
                      leftTitles: FitnessBarTitles.getSideTitles(),
                      topTitles: SideTitles(showTitles: false),
                      rightTitles: SideTitles(showTitles: false),
                    ),
                  ),
                ),
              ),
              historyWorkoutViewModel.totalWeeklyWorkouts != 0
                  ? Container(
                      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      height: sizeV * 8,
                      width: sizeH * 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: SizedBox(
                                  width: sizeH * 58,
                                  child: Text(
                                    historyWorkoutViewModel.week,
                                    style: TextStyle(
                                      color: accentColor,
                                      fontSize: sizeV * 2.5,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: sizeH * 30,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.timer_outlined,
                                      size: sizeV * 2,
                                      color: grey,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      workoutViewModel.formatWorkoutTime(
                                          historyWorkoutViewModel
                                              .totalWeeklyMinutes),
                                      style: TextStyle(
                                        color: grey,
                                        fontSize: sizeV * 2,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                                child: SizedBox(
                                  width: sizeH * 58,
                                  child: Text(
                                    "${historyWorkoutViewModel.totalWeeklyWorkouts} workouts",
                                    style: TextStyle(
                                      color: grey,
                                      fontSize: sizeV * 2,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: sizeH * 30,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.bolt,
                                      size: sizeV * 2,
                                      color: grey,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      '${historyWorkoutViewModel.totalWeeklyKcal.toStringAsFixed(2)} kcal',
                                      style: TextStyle(
                                        color: grey,
                                        fontSize: sizeV * 2,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(height: 2, color: metalGreyColor),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              Container(
                margin:
                    EdgeInsets.fromLTRB(sizeH * 6, sizeV, sizeH * 6, sizeV * 2),
                padding: EdgeInsets.all(sizeV),
                height: 250,
                width: sizeH * 100,
                child: historyWorkoutViewModel.isLoadingWorkouts
                    ? spinkit
                    : (historyWorkoutViewModel.listHistory == []
                        ? const SizedBox(
                            height: 20,
                            child: Center(
                              child: Text(
                                "You haven't take any exercise",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.black),
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount:
                                historyWorkoutViewModel.listHistory.length,
                            itemBuilder: (context, index) {
                              HistoryWorkoutDay historyWorkoutDay =
                                  historyWorkoutViewModel.listHistory[index];
                              return historyWorkoutItem(historyWorkoutDay);
                            },
                          )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
