import 'package:wecare_flutter/model/exercise/exercise.dart';

class ExerciseArguments {
  final String banner;
  final List<Exercise> listExercise;
  final String tag;

  ExerciseArguments(
      {required this.tag, required this.banner, required this.listExercise});
}
