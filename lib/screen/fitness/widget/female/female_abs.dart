import 'package:flutter/material.dart';
import 'package:wecare_flutter/model/exercise/exercise.dart';
import 'package:wecare_flutter/model/exercise/exercise_arguments.dart';
import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/screen/fitness/introduce_screen.dart';
import 'package:wecare_flutter/screen/fitness/widget/workout.dart';

class FemaleAbs extends StatelessWidget {
  const FemaleAbs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(
          height: 6,
        ),
        BannerWorkouts(
          tag: "arm_begin",
          srcImage: 'assets/images/exercises/banner/female_abs1.png',
          press: () {
            final args = ExerciseArguments(
                tag: "arm_begin",
                banner: "assets/images/exercises/intro/arm_begin.png",
                listExercise: listArmBeginner);
            Navigator.pushNamed(
              context,
              Routes.introworkout,
              arguments: args,
            );
          },
        ),
        const SizedBox(
          height: 6,
        ),
        BannerWorkouts(
          tag: "arm_intermediate",
          srcImage: 'assets/images/exercises/banner/female_abs2.png',
          press: () {
            final args = ExerciseArguments(
                tag: "arm_intermediate",
                banner: "assets/images/exercises/intro/arm_begin.png",
                listExercise: listArmInter);
            Navigator.pushNamed(
              context,
              Routes.introworkout,
              arguments: args,
            );
          },
        ),
        const SizedBox(
          height: 6,
        ),
        BannerWorkouts(
          tag: "arm_advanced",
          srcImage: 'assets/images/exercises/banner/female_abs3.png',
          press: () {
            final args = ExerciseArguments(
                tag: "arm_advanced",
                banner: "assets/images/exercises/intro/arm_begin.png",
                listExercise: listArmAdvanced);
            Navigator.pushNamed(
              context,
              Routes.introworkout,
              arguments: args,
            );
          },
        ),
      ],
    );
  }
}
