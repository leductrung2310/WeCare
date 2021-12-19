import 'package:flutter/material.dart';
import 'package:wecare_flutter/model/exercise/exercise.dart';
import 'package:wecare_flutter/model/exercise/exercise_arguments.dart';
import 'package:wecare_flutter/routes.dart';
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
          tag: "female_abs_begin",
          srcImage: 'assets/images/exercises/banner/female/female_abs1.png',
          press: () {
            final args = ExerciseArguments(
                tag: "female_abs_begin",
                banner: "assets/images/exercises/intro/female_abs_begin.png",
                listExercise: listAbsFemaleBeginner);
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
          tag: "female_abs_intern",
          srcImage: 'assets/images/exercises/banner/female/female_abs2.png',
          press: () {
            final args = ExerciseArguments(
                tag: "female_abs_intern",
                banner: "assets/images/exercises/intro/female_abs_intern.png",
                listExercise: listAbsFemaleInter);
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
          tag: "female_abs_advanced",
          srcImage: 'assets/images/exercises/banner/female/female_abs3.png',
          press: () {
            final args = ExerciseArguments(
                tag: "female_abs_advanced",
                banner: "assets/images/exercises/intro/female_abs_advanced.png",
                listExercise: listAbsFemaleAdvanced);
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
