import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/services/authentic_service.dart';
import 'package:wecare_flutter/view_model/home_vm/water_view_model.dart';

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

    WaterViewModel waterViewModel = Provider.of<WaterViewModel>(context);

    AuthenticService authenticService = Provider.of<AuthenticService>(context);

    return Align(
      alignment: Alignment.center,
      child: TweenAnimationBuilder(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(seconds: 1),
        builder: (BuildContext _, double value, child) {
          int percentage = (value *
                  ((waterViewModel.getCurrentIndex /
                          authenticService.getDesiredAmount) *
                      100))
              .ceil();
          if(percentage > 100) {
            percentage = 100;
          }
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
                      stops: [
                        value *
                            (waterViewModel.getCurrentIndex /
                                authenticService.getDesiredAmount),
                        value *
                            (waterViewModel.getCurrentIndex /
                                authenticService.getDesiredAmount)
                      ],
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
