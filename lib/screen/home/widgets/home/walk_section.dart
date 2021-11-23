import 'package:flutter/material.dart';
import 'package:svg_icon/svg_icon.dart';

import '../../../../constants/constants.dart';

class StepCountPart extends StatelessWidget {
  const StepCountPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return InkWell(
      splashColor: grey1,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: sizeV * 15.5,
        width: sizeH * 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: lightBlack1, width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const WalkItem(
              assetName: 'assets/images/home/walk/step_icon.svg',
              index: 7500,
              name: 'Steps',
              color: stepColor,
              unit: '',
            ),
            SizedBox(width: sizeH * 1.5),
            const WalkItem(
              assetName: 'assets/images/home/walk/distance.svg',
              index: 3500,
              name: 'Distance',
              color: distanceColor,
              unit: 'm',
            ),
            SizedBox(width: sizeH * 1.5),
            const WalkItem(
              assetName: 'assets/images/home/walk/flashspeed.svg',
              index: 12,
              name: 'Speed',
              color: speedColor,
              unit: 'm/s',
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }
}

class WalkItem extends StatelessWidget {
  const WalkItem({
    Key? key,
    required this.assetName,
    required this.index,
    required this.name,
    required this.color,
    required this.unit,
  }) : super(key: key);
  final String assetName;
  final String name;
  final double index;
  final Color color;
  final String unit;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgIcon(
          assetName,
          height: sizeV * 4.5,
          width: sizeH * 6,
          color: color,
        ),
        SizedBox(height: sizeV * 0.7),
        // ignore: sized_box_for_whitespace
        Container(
          height: sizeV * 3.5,
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: sizeV * 3,
                fontWeight: FontWeight.w600,
                color: lightBlack,
              ),
              children: [
                TextSpan(
                  text: index.toStringAsFixed(
                    index.truncateToDouble() == index ? 0 : 2,
                  ),
                ),
                TextSpan(
                  text: unit,
                  style: TextStyle(
                    fontSize: sizeV * 2,
                    fontFamily: 'Poppins',
                    color: lightBlack1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        Text(
          name,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: sizeV * 2.3,
            fontWeight: FontWeight.w600,
            color: lightBlack1,
          ),
        ),
      ],
    );
  }
}
