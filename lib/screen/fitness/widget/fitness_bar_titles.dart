import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/model/statistic_data/statistic_data.dart';

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
  static double interval = 150;

  static List<FitnessStatisticData> fitnessBarData = [
    FitnessStatisticData(0, 'Mo', 320, primaryColor),
    FitnessStatisticData(1, 'Tu', 370, primaryColor),
    FitnessStatisticData(2, 'We', 240, primaryColor),
    FitnessStatisticData(3, 'Th', 300, primaryColor),
    FitnessStatisticData(4, 'Fr', 550, primaryColor),
    FitnessStatisticData(5, 'Sa', 450, primaryColor),
    FitnessStatisticData(6, 'Su', 600, primaryColor),
  ];

  static List<BarChartGroupData> fitnessBarChartList = fitnessBarData
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

class FitnessStatisticData extends StatticticData {
  FitnessStatisticData(int id, String name, double y, Color color)
      : super(id, name, y, color);
}
