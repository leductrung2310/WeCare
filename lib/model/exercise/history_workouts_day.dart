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

  Map<String, dynamic> toJson() {
    return {
      'workouts': workouts,
      'time': time,
      'minutes': minutes,
      'kcal': kcal,
    };
  }

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

  factory HistoryWorkoutDay.fromDocument(DocumentSnapshot doc) {
    Timestamp time = doc['time'];

    return HistoryWorkoutDay(
        workouts: doc['workouts'],
        time: time.toDate(),
        minutes: doc['minutes'],
        kcal: checkDouble(doc['kcal']));
  }
}

class Day {
  int? day;

  Day({
    this.day,
  });

  Map<String, dynamic> toJson() {
    return {
      'day': day,
    };
  }

  factory Day.fromMap(map) {
    return Day(day: map['day']);
  }
}

class ChartData {
  double? totalKcalDay;
  int? totalMinuteDay;
  int? totalWorkoutsDay;

  ChartData({
    this.totalKcalDay,
    this.totalMinuteDay,
    this.totalWorkoutsDay,
  });

  static double checkDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    }
    return value;
  }

  Map<String, dynamic> toJson() {
    return {
      'totalKcalDay': totalKcalDay,
      'totalMinuteDay': totalMinuteDay,
      'totalWorkoutsDay': totalWorkoutsDay,
    };
  }

  factory ChartData.fromMap(map) {
    return ChartData(
        totalKcalDay: checkDouble(map['totalKcalDay']),
        totalMinuteDay: map['totalMinuteDay'],
        totalWorkoutsDay: map['totalWorkoutsDay']);
  }
}
