import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryWorkoutDay {
  String? workouts;
  DateTime? time;
  int? minutes;
  double? kcal;

  HistoryWorkoutDay({
    this.workouts,
    this.time,
    this.minutes,
    this.kcal,
  });

  static double checkDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    }
    return value;
  }

  factory HistoryWorkoutDay.fromMap(map) {
    Timestamp timeTimestamp = map['time'];
    DateTime? timeDatetime = timeTimestamp.toDate();

    return HistoryWorkoutDay(
        workouts: map['workouts'],
        time: timeDatetime,
        minutes: map['minutes'],
        kcal: checkDouble(map['kcal']));
  }
}
