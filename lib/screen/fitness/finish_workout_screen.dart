import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wecare_flutter/constants.dart';

import '../../routes.dart';

class FinishWorkout extends StatelessWidget {
  const FinishWorkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Congratulation!",
            style: oTitle,
          ),
          Text(
            "You did it ",
            style: oTitle,
          ),
          Image.asset(
            "assets/images/exercises/finish_workout.png",
            height: sizeV * 40,
            fit: BoxFit.contain,
          ),
          SizedBox(
            height: sizeV * 5,
          ),
          Container(
            height: sizeV * 12,
            width: sizeH * 90,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 2,
                color: metalGreyColor,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: sizeV,
                    ),
                    Text(
                      "10",
                      style: oTitle,
                    ),
                    Text(
                      "Workouts",
                      style: oSubtitle,
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: sizeV,
                    ),
                    Text(
                      "23",
                      style: oTitle,
                    ),
                    Text(
                      "Minutes",
                      style: oSubtitle,
                    )
                  ],
                ),
                Column(
                  children: [
                    SizedBox(
                      height: sizeV,
                    ),
                    Text(
                      "231.0",
                      style: oTitle,
                    ),
                    Text(
                      "Kcal",
                      style: oSubtitle,
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: sizeV * 5,
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.main,
                );
              },
              child: Container(
                height: sizeV * 6,
                width: sizeH * 70,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    "Finish",
                    style: TextStyle(
                      fontSize: sizeV * 2.8,
                      fontFamily: "poppins",
                      color: whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
