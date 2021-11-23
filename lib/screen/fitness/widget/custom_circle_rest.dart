import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class RestCircle extends StatelessWidget {
  const RestCircle({Key? key}) : super(key: key);

  static const TWO_PI = 3.14 * 2;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final size = sizeH * 55;
    return Center(
      child: TweenAnimationBuilder(
        duration: const Duration(seconds: 30),
        tween: Tween(
          begin: 0.0,
          end: 1.0,
        ),
        builder: (context, double value, child) {
          int percentage = (value * 30).ceil();
          return Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Stack(
              children: [
                ShaderMask(
                  shaderCallback: (rect) {
                    return SweepGradient(
                      startAngle: 0.0,
                      endAngle: TWO_PI,
                      center: Alignment.center,
                      stops: [value, value],
                      colors: const [
                        primaryColor,
                        Colors.transparent,
                      ],
                    ).createShader(rect);
                  },
                  child: Container(
                    width: size,
                    height: size,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: whiteColor,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    height: size - 20,
                    width: size - 20,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: whiteColor,
                    ),
                    child: Center(
                      child: Text(
                        "00:$percentage",
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 54,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
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
