import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wecare_flutter/screen/home/water/components/weekly_calendar.dart';
import 'package:wecare_flutter/screen/home/water/components/fl_bar_chart.dart';

import '../../../../constants/constants.dart';

// ignore: must_be_immutable
class AnimatedChart extends StatelessWidget {
  AnimatedChart({
    Key? key,
    required this.color,
    required this.barWidth,
    required this.width,
    required this.height,
    required this.barChartGroupData,
    required this.flTitlesData,
    required this.onPressed1,
    required this.onPressed2,
    this.widget,
    this.isEmptyData,
  }) : super(key: key);

  final Color color;
  final double barWidth;
  final double width;
  final double height;
  final List<BarChartGroupData> barChartGroupData;
  final FlTitlesData flTitlesData;
  final Function() onPressed1;
  final Function() onPressed2;
  Widget? widget = const SizedBox.shrink();
  bool? isEmptyData = false;

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WeeklyCalendar(
              color: color,
              onPressed1: () => onPressed1(),
              onPressed2: () => onPressed2(),
            ),
            SizedBox(
              height: sizeV * 2,
            ),
            Expanded(
              child: isEmptyData == true
                  ? widget!
                  : FlBarChart(
                      sizeH: sizeH,
                      flTitlesData: flTitlesData,
                      barGroups: barChartGroupData,
                      barTouch: true,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
