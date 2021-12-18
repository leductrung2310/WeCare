import 'package:cloud_firestore/cloud_firestore.dart';

class TotalWeekly {
  String? week;
  int? totalWorkouts;
  int? totalMinutes;
  double? totalKcal;

  TotalWeekly({
    this.week,
    this.totalWorkouts,
    this.totalMinutes,
    this.totalKcal,
  });

  static double checkDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    }
    return value;
  }

  factory TotalWeekly.fromMap(map) {
    return TotalWeekly(
        week: map['week'].toString(),
        totalWorkouts: map['totalWorkouts'],
        totalMinutes: map['totalMinutes'],
        totalKcal: checkDouble(map['totalKcal']));
  }

  Map<String, dynamic> toMap() {
    return {
      "week": week,
      "totalWorkouts": totalWorkouts,
      "totalMinutes": totalMinutes,
      "totalKcal": totalKcal
    };
  }

  factory TotalWeekly.fromDocument(DocumentSnapshot doc) {
    return TotalWeekly(
        week: doc['week'],
        totalWorkouts: doc['totalWorkouts'],
        totalMinutes: doc['totalMinutes'],
        totalKcal: checkDouble(doc['totalKcal']));
  }
}
