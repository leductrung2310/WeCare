import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/model/exercise/exercise.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/screen/fitness/widget/custom_btn.dart';
import 'package:wecare_flutter/screen/fitness/widget/custom_circle_rest.dart';
import 'package:wecare_flutter/screen/onboarding_screen/widgets/custom_button.dart';
import 'package:wecare_flutter/view_model/exercise/exercise_view_model.dart';

import '../../routes.dart';

class RestScreen extends StatelessWidget {
  final List<Exercise> arguments;

  const RestScreen({Key? key, required this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final workoutViewModel = Provider.of<WorkoutViewModel>(context);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: sizeV * 5),
                SizedBox(
                    height: sizeV * 35,
                    child: Text(
                      "${workoutViewModel.restTime}",
                      style: const TextStyle(fontSize: 50),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomBTN(
                      textColor: whiteColor,
                      name: "+ 20s",
                      onPressed: () {
                        Provider.of<WorkoutViewModel>(context, listen: false)
                            .plusRestTime(20);
                      },
                      color: primaryColor,
                      height: sizeV * 7,
                      width: sizeH * 25,
                    ),
                    CustomBTN(
                      textColor: whiteColor,
                      name: "Skip",
                      onPressed: () {
                        final arg = arguments;
                        Navigator.pushReplacementNamed(
                          context,
                          Routes.workouting,
                          arguments: arg,
                        );
                      },
                      color: primaryColor,
                      height: sizeV * 7,
                      width: sizeH * 25,
                    ),
                  ],
                ),
                SizedBox(
                  height: sizeV * 3,
                ),
                SizedBox(
                  height: sizeV,
                  child: Container(
                    color: metalGreyColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        "Next ",
                        style: TextStyle(
                          color: metalGreyColor,
                          fontSize: sizeV * 3,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        " ${workoutViewModel.indexWorkout + 2}/${arguments.length}",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: sizeV * 3,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                  child: Text(
                    arguments[workoutViewModel.indexWorkout + 1].name,
                    style: TextStyle(
                      color: accentColor,
                      fontSize: sizeV * 3,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                  child: Text(
                    arguments[workoutViewModel.indexWorkout + 1].reps,
                    style: TextStyle(
                      color: accentColor,
                      fontSize: sizeV * 3,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    arguments[workoutViewModel.indexWorkout + 1].gif,
                    height: sizeV * 25,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
