import 'package:flutter/material.dart';
import 'package:wecare_flutter/screen/home/widgets/home/home_item.dart';

import '../../../constants.dart';
import '../../../routes.dart';

class LeftSection extends StatelessWidget {
  const LeftSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

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
          child: const Text(''),
          left: 5,
          top: 5,
          right: 5,
          bottom: 5,
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
