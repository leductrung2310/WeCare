import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/model/water_statistic_data.dart';

class WaterBarTitles {
  static SideTitles getBottomTitles() => SideTitles(
        showTitles: true,
        getTextStyles: (context, value) => TextStyle(
          color: lightBlack1,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: SizeConfig.blockSizeV! * 2,
        ),
        getTitles: (double id) => WaterBarData.waterBarData
            .firstWhere((element) => element.id == id.toInt())
            .name,
      );

  static SideTitles getSideTitles() => SideTitles(
        showTitles: true,
        getTextStyles: (context, value) => TextStyle(
          color: lightBlack1,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: SizeConfig.blockSizeV! * 1.6,
        ),
        margin: 10,
        interval: WaterBarData.interval,
        reservedSize: 30,
        getTitles: (double value) => value == 0 ? '0' : '${value}L',
      );
}
