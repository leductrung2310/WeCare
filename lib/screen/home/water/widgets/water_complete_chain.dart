import 'package:flutter/material.dart';

import '../../../../constants.dart';

class WaterCompletedChain extends StatelessWidget {
  const WaterCompletedChain({Key? key}) : super(key: key);

  Container _waterDrop(double percentage) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/home/water/water_drop.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Container(
      width: sizeH * 90,
      height: sizeV * 15,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: waterColor,
        ),
        boxShadow: [
          BoxShadow(
            color: lightWaterColor,
            offset: const Offset(5.0, 5.0),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
    );
  }
}
