import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/screen/home/water/widgets/animated_chart.dart';
import 'package:wecare_flutter/screen/home/widgets/tools/appbar.dart';

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
              SizedBox(height: sizeV*3),
              Align(
                alignment: Alignment.topCenter,
                child: AnimatedChart(
                  color: waterColor,
                  barWidth: sizeH*4,
                  width: sizeH * 90,
                  height: sizeV * 40,
                  maxY: 2.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
