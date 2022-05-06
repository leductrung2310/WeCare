import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class RestCircle extends StatelessWidget {
  final int time;
  const RestCircle({Key? key, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;

    final size = sizeH * 55;
    return Center(
      child: TweenAnimationBuilder(
        duration: Duration(seconds: time),
        tween: Tween(
          begin: 1.0,
          end: 0.0,
        ),
        builder: (context, double value, child) {
          int percentage = (value * time).ceil();
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
                      endAngle: 3.14 * 2,
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
                        percentage > 9 ? "00:$percentage" : "00:0$percentage",
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
