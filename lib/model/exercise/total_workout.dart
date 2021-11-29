import 'package:wecare_flutter/screen/fitness/widget/total_history.dart';

class TotalWorkouts {
  int? totalWorkouts;
  int? totalMinutes;
  double? totalKcal;

  TotalWorkouts({
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

  TotalWorkouts.fromMap(map) {
    totalWorkouts = map['totalWorkouts'];
    totalMinutes = map['totalMinutes'];
    totalKcal = checkDouble(map['totalKcal']);
  }

  Map<String, dynamic> toMap() {
    return {
      "totalWorkouts": totalWorkouts,
      "totalMinutes": totalMinutes,
      "totalKcal": totalKcal
    };
  }
}
