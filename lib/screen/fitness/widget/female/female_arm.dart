import 'package:flutter/material.dart';
import 'package:wecare_flutter/model/exercise/exercise.dart';
import 'package:wecare_flutter/model/exercise/exercise_arguments.dart';
import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/screen/fitness/widget/workout.dart';

class FemaleArm extends StatelessWidget {
  const FemaleArm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 6,
        ),
        BannerWorkouts(
          tag: "female_abs_begin",
          srcImage:
              'assets/images/exercises/banner/female/arm_intermediate.png',
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
      ],
    );
  }
}
