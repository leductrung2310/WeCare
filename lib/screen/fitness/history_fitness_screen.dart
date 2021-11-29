import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/screen/fitness/widget/fitness_bar_titles.dart';
import 'package:wecare_flutter/screen/fitness/widget/total_history.dart';
import 'package:wecare_flutter/screen/home/water/widgets/animated_chart.dart';
import 'package:wecare_flutter/screen/home/widgets/tools/appbar.dart';
import 'package:wecare_flutter/view_model/weekly_calendar_viewmodel.dart';

class FitnessHistoryScreen extends StatelessWidget {
  const FitnessHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

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
                    color: primaryColor,
                    barWidth: sizeH * 4,
                    width: sizeH * 90,
                    height: sizeV * 45,
                    maxY: 0,
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
            ],
          ),
        ),
      ),
    );
  }
}
