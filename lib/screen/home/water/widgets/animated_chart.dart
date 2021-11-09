import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wecare_flutter/screen/home/water/components/calendar_picker.dart';
import 'package:wecare_flutter/screen/home/water/components/fl_bar_chart.dart';

import '../../../../constants.dart';

class AnimatedChart extends StatelessWidget {
  const AnimatedChart({
    Key? key,
    required this.color,
    required this.barWidth,
    required this.width,
    required this.height,
    required this.maxY,
    required this.flTitlesData,
  }) : super(key: key);

  final Color color;
  final double barWidth;
  final double width;
  final double height;
  final double maxY;
  final FlTitlesData flTitlesData;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: lightWaterColor,
            offset: const Offset(5.0, 5.0),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: sizeH * 3,
          vertical: sizeV * 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WeeklyCalendar(color: color),
            SizedBox(
              height: sizeV * 2,
            ),
            Expanded(
              child: FlBarChart(
                maxY: maxY,
                sizeH: sizeH,
                flTitlesData: flTitlesData,
                barWidth: barWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}