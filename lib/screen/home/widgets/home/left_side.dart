import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wecare_flutter/model/statistic_data/sleep_statistic_data.dart';
import 'package:wecare_flutter/screen/home/water/components/fl_bar_chart.dart';
import 'package:wecare_flutter/screen/home/widgets/home/home_item.dart';

import '../../../../constants/constants.dart';
import '../../../../routes.dart';

class LeftSection extends StatelessWidget {
  const LeftSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    Widget homeScreenFlChart = FlBarChart(
      sizeH: sizeH * 0.5,
      flTitlesData: FlTitlesData(show: false),
      barGroups: SleepBarData.sleepBarChartList,
      barTouch: false,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        HomeItem(
          color: sleepColor,
          name: 'Sleep',
          assetIcon: 'assets/images/home/sleep/sleep.svg',
          index: 7.5,
          coefficient: 30,
          child: homeScreenFlChart,
          left: sizeH * 2,
          top: sizeV * 6,
          right: sizeH * 2,
          bottom: sizeV * 7,
          unit: 'H',
          onPressed: () {
            Navigator.pushNamed(context, Routes.sleepScreen);
          },
        ),
        SizedBox(height: sizeH * 5),
        HomeItem(
          color: caloriesColor,
          name: 'Calories',
          assetIcon: 'assets/images/home/calories/calories.svg',
          index: 759,
          coefficient: 15,
          child: const Text(''),
          left: 5,
          top: 5,
          right: 5,
          bottom: 5,
          unit: '',
          onPressed: () {},
        ),
      ],
    );
  }
}
