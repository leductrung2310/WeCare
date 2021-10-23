import 'package:flutter/material.dart';
import 'package:wecare_flutter/screen/home/widgets/home_item.dart';
import 'package:wecare_flutter/screen/home/widgets/water_progress.dart';

import '../../../constants.dart';

class RightSection extends StatelessWidget {
  const RightSection({Key? key}) : super(key: key);

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
          color: waterColor,
          name: 'Water',
          assetIcon: 'assets/images/home/water/water_drop.svg',
          index: 1.29,
          coefficient: 22.5,
          child: const CustomProgressIndicator(),
          left: sizeV*5.5,
          top: sizeV*6,
          right: sizeV*5.5,
          bottom: sizeV*6,
          unit: 'L',
          onPressed: (){
            Navigator.pushNamed(context, '/water_screen');
          },
        ),
        SizedBox(height: sizeH * 5),
        HomeItem(
          color: bmiColor,
          name: 'BMI Ratio',
          assetIcon: 'assets/images/home/bmi/bmi_weight.svg',
          index: 20.5,
          coefficient: 22.5,
          child: const Text(''),
          left: 5,
          top: 5,
          right: 5,
          bottom: 5,
          unit: '',
          onPressed: (){
            Navigator.pushNamed(context, '/bmi_screen');
          },
        ),
      ],
    );
  }
}
