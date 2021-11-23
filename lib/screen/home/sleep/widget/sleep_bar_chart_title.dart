import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/model/statistic_data/sleep_statistic_data.dart';

class SleepBarTitles {
  static SideTitles getBottomTitles() => SideTitles(
        showTitles: true,
        getTextStyles: (context, value) => TextStyle(
          color: lightBlack1,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: SizeConfig.blockSizeV! * 1.8,
        ),
        getTitles: (double id) => SleepBarData.statisticListData
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
      interval: SleepBarData.interval,
      reservedSize: 40,
      getTitles: (double value) => value == 0 ? '0' : '${value}H',
    );
  }
}
