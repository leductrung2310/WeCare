import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FlBarChart extends StatelessWidget {
  const FlBarChart({
    Key? key,
    required this.sizeH,
    required this.flTitlesData,
    required this.barGroups,
    required this.barTouch,
  }) : super(key: key);

  final double sizeH;
  final FlTitlesData flTitlesData;
  final List<BarChartGroupData> barGroups;
  final bool barTouch;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.center,
        minY: 0,
        groupsSpace: sizeH * 6,
        barTouchData: BarTouchData(enabled: barTouch),
        borderData: FlBorderData(show: false),
        titlesData: flTitlesData,
        gridData: FlGridData(
          show: false,
        ),
        barGroups: barGroups,
      ),
    );
  }
}
