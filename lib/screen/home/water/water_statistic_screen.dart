import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/screen/home/water/widgets/detailed_statistic.dart';
import 'package:wecare_flutter/screen/home/water/widgets/water_complete_chain.dart';
import 'package:wecare_flutter/screen/home/widgets/tools/appbar.dart';

import 'widgets/water_weekly_chart.dart';

class WaterStatisticScreen extends StatelessWidget {
  const WaterStatisticScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
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
              const WaterWeeklyChart(),
              SizedBox(height: sizeV * 3),
              const DetailedStatistic(),
              SizedBox(height: sizeV * 3),
              const WaterCompletedChain(),
              SizedBox(height: sizeV * 3),
            ],
          ),
        ),
      ),
    );
  }
}
