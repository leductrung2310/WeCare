import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/screen/home/water/widgets/animated_chart.dart';
import 'package:wecare_flutter/screen/home/widgets/tools/appbar.dart';
import 'package:wecare_flutter/view_model/weekly_calendar_viewmodel.dart';

import 'widgets/water_bar_chart_title.dart';

class WaterStatisticScreen extends StatelessWidget {
  const WaterStatisticScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: customAppBar(
          context,
          waterColor,
          'Statistic',
          const Text(''),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: sizeV * 2.5),
              Align(
                alignment: Alignment.topCenter,
                child: ChangeNotifierProvider(
                  create: (context) => CalendarViewModel(),
                  child: AnimatedChart(
                    color: waterColor,
                    barWidth: sizeH * 5,
                    width: sizeH * 90,
                    height: sizeV * 45,
                    maxY: 2.2,
                    flTitlesData: FlTitlesData(
                      bottomTitles: WaterBarTitles.getBottomTitles(),
                      leftTitles: WaterBarTitles.getSideTitles(),
                      topTitles: SideTitles(showTitles: false),
                      rightTitles: SideTitles(showTitles: false),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
