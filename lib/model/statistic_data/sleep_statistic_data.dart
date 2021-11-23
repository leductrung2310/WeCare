import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/model/statistic_data/statistic_data.dart';

class SleepStatisticData extends StatticticData {
  SleepStatisticData(int id, String name, double y, Color color)
      : super(id, name, y, color);
}

class SleepBarData {

  static double interval = 2.5;

  static List<SleepStatisticData> statisticListData = [
    SleepStatisticData(0, 'M', 7, sleepColor),
    SleepStatisticData(1, 'T', 7.5, sleepColor),
    SleepStatisticData(2, 'W', 8, sleepColor),
    SleepStatisticData(3, 'T', 6, sleepColor),
    SleepStatisticData(4, 'F', 9, sleepColor),
    SleepStatisticData(5, 'S', 5, sleepColor),
    SleepStatisticData(6, 'S', 6.5, sleepColor),
  ];

  static List<BarChartGroupData> sleepBarChartList = SleepBarData.statisticListData
        .map(
          (SleepStatisticData data) => BarChartGroupData(
            x: data.id,
            barRods: [
              BarChartRodData(
                y: data.y,
                colors: [data.color],
              ),
            ],
          ),
        )
        .toList();
}
