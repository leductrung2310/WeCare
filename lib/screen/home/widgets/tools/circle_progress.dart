import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';

const twoPi = 3.14 * 2;
const target = 2;
double currentWater = 1.29;

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeV = SizeConfig.blockSizeV!;

    final size = sizeV * 10;

    return Align(
      alignment: Alignment.center,
      child: TweenAnimationBuilder(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(seconds: 1),
        builder: (BuildContext _, double value, child) {
          int percentage = (value * ((1.29 / 2) * 100)).ceil();
          return Container(
            height: size,
            width: size,
            color: Colors.transparent,
            child: Stack(
              children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return SweepGradient(
                      startAngle: 0.0,
                      endAngle: twoPi,
                      center: Alignment.center,
                      //The stops[] must have the same length as colors[]
                      stops: [value * (1.29 / 2), value * (1.29 / 2)],
                      colors: [waterColor, Colors.grey.withAlpha(55)],
                    ).createShader(rect);
                  },
                  child: Container(
                    height: size,
                    width: size,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: sizeV * 8,
                    width: sizeV * 8,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: whiteColor,
                    ),
                    child: Center(
                      child: Text(
                        '$percentage%',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: sizeV * 2.5,
                          color: waterColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
