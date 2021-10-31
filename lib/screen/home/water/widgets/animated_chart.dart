import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wecare_flutter/model/water_statistic_data.dart';
import 'package:wecare_flutter/screen/home/water/widgets/bar_chart_title.dart';

import '../../../../constants.dart';

class AnimatedChart extends StatelessWidget {
  const AnimatedChart({
    Key? key,
    required this.color,
    required this.barWidth,
    required this.width,
    required this.height,
    required this.maxY,
  }) : super(key: key);

  final Color color;
  final double barWidth;
  final double width;
  final double height;
  final double maxY;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: color,
          width: 2,
        ),
      ),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.center,
          maxY: maxY,
          minY: 0,
          groupsSpace: sizeH*6,
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            bottomTitles: BarTitles.getBottomTitles(),
            leftTitles: BarTitles.getSideTitles(),
            rightTitles: BarTitles.getSideTitles(),
          ),
          barGroups: WaterBarData.waterBarData
              .map(
                (data) => BarChartGroupData(
                  x: data.id,
                  barRods: [
                    BarChartRodData(
                      y: data.y,
                      width: barWidth,
                      colors: [data.color],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
