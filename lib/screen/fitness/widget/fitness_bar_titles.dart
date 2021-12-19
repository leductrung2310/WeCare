import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/model/exercise/history_workouts_day.dart';
import 'package:wecare_flutter/model/statistic_data/statistic_data.dart';
import 'package:wecare_flutter/view_model/exercise/history_workout_view_model.dart';

class FitnessBarTitles {
  static SideTitles getBottomTitles() => SideTitles(
        showTitles: true,
        getTextStyles: (context, value) => TextStyle(
          color: lightBlack1,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: SizeConfig.blockSizeV! * 1.8,
        ),
        getTitles: (double id) => FitnessBarData.fitnessBarData
            .firstWhere((element) => element.id == id.toInt())
            .name,
      );

  static SideTitles getSideTitles() {
    return SideTitles(
      showTitles: true,
      getTextStyles: (context, value) => TextStyle(
        color: lightBlack1,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
        fontSize: SizeConfig.blockSizeV! * 1.6,
      ),
      margin: 10,
      interval: FitnessBarData.interval,
      reservedSize: 30,
      getTitles: (double value) => value == 0 ? '0' : '${value.toInt()}\nkcal',
    );
  }
}

class FitnessBarData {
  static double interval = 100;

  static List<FitnessStatisticData> fitnessBarData = [
    FitnessStatisticData(0, 'Mo', 0, primaryColor),
    FitnessStatisticData(1, 'Tu', 0, primaryColor),
    FitnessStatisticData(2, 'We', 0, primaryColor),
    FitnessStatisticData(3, 'Th', 0, primaryColor),
    FitnessStatisticData(4, 'Fr', 0, primaryColor),
    FitnessStatisticData(5, 'Sa', 0, primaryColor),
    FitnessStatisticData(6, 'Su', 0, primaryColor),
  ];

  static List<BarChartGroupData> fitnessBarChartList(BuildContext context) {
    final historyWorkoutsViewModel =
        Provider.of<HistoryWorkoutViewModel>(context, listen: false);

    List<ChartData> list = historyWorkoutsViewModel.listData;

    List<FitnessStatisticData> fitnessBarData = [
      FitnessStatisticData(0, 'Mo', list[0].totalKcalDay!, primaryColor),
      FitnessStatisticData(1, 'Tu', list[1].totalKcalDay!, primaryColor),
      FitnessStatisticData(2, 'We', list[2].totalKcalDay!, primaryColor),
      FitnessStatisticData(3, 'Th', list[3].totalKcalDay!, primaryColor),
      FitnessStatisticData(4, 'Fr', list[4].totalKcalDay!, primaryColor),
      FitnessStatisticData(5, 'Sa', list[5].totalKcalDay!, primaryColor),
      FitnessStatisticData(6, 'Su', list[6].totalKcalDay!, primaryColor),
    ];

    return fitnessBarData
        .map(
          (FitnessStatisticData data) => BarChartGroupData(
            x: data.id,
            barRods: [
              BarChartRodData(
                y: data.y,
                width: SizeConfig.blockSizeH! * 2.5,
                colors: [data.color],
              ),
            ],
          ),
        )
        .toList();
  }
}

class FitnessStatisticData extends StatticticData {
  FitnessStatisticData(int id, String name, double y, Color color)
      : super(id, name, y, color);
}
