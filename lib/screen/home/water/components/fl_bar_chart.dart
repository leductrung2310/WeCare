import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wecare_flutter/model/water_statistic_data.dart';

class FlBarChart extends StatelessWidget {
  const FlBarChart({
    Key? key,
    required this.maxY,
    required this.sizeH,
    required this.flTitlesData,
    required this.barWidth,
  }) : super(key: key);

  final double maxY;
  final double sizeH;
  final FlTitlesData flTitlesData;
  final double barWidth;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.center,
        maxY: maxY,
        minY: 0,
        groupsSpace: sizeH * 5,
        barTouchData: BarTouchData(enabled: true),
        borderData: FlBorderData(show: false),
        titlesData: flTitlesData,
        gridData: FlGridData(
          checkToShowHorizontalLine: (value) =>
              value % WaterBarData.interval == 0,
          getDrawingHorizontalLine: (value) {
            if (value == 0) {
              return FlLine(
                color: const Color(0xff363753),
                strokeWidth: 3,
              );
            } else {
              return FlLine(
                color: const Color(0xff2a2747),
                strokeWidth: 0.5,
              );
            }
          },
        ),
        barGroups: WaterBarData.waterBarData
            .map(
              (WaterStatisticData data) => BarChartGroupData(
                x: data.id,
                barRods: [
                  BarChartRodData(
                    y: data.y,
                    width: barWidth,
                    colors: [data.color],
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
