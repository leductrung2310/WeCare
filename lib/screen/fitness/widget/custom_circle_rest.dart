import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/view_model/exercise/exercise_view_model.dart';

import '../../../constants.dart';

class RestCircle extends StatelessWidget {
  const RestCircle({Key? key}) : super(key: key);

  static const TWO_PI = 3.14 * 2;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final workoutViewModel = Provider.of<WorkoutViewModel>(context);

    final size = sizeH * 55;
    return Center(
      child: TweenAnimationBuilder(
        duration: Duration(seconds: workoutViewModel.restTime),
        tween: Tween(
          begin: 1.0,
          end: 0.0,
        ),
        builder: (context, double value, child) {
          int percentage = (value * workoutViewModel.restTime).ceil();
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
