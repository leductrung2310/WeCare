import 'package:flutter/material.dart';

class WeeklyCalendarVM extends ChangeNotifier {
  late DateTime startOfWeek;
  late DateTime endOfWeek;

  DateTime get getStartOfWeek => startOfWeek;

  DateTime get getEndOfWeek => endOfWeek;

  DateTime currentTime = DateTime.now();

  WeeklyCalendarVM() {
    startOfWeek = currentTime.subtract(Duration(days: currentTime.weekday - 1));
    endOfWeek = currentTime
        .add(Duration(days: DateTime.daysPerWeek - currentTime.weekday));
    notifyListeners();
  }

  String getCalendar() {
    String startOfWeekMonth =
        startOfWeek.month == endOfWeek.month ? '' : '/${startOfWeek.month}';
    String startOfWeekYear =
        startOfWeek.year == endOfWeek.year ? '' : ', ${startOfWeek.year}';
    return '${startOfWeek.day}$startOfWeekMonth$startOfWeekYear-${endOfWeek.day}/${endOfWeek.month}, ${endOfWeek.year}';
  }

  void changeCalendar(bool isPrevious) {
    if (isPrevious) {
      currentTime = currentTime.subtract(const Duration(days: 7));
      startOfWeek =
          currentTime.subtract(Duration(days: currentTime.weekday - 1));
      endOfWeek = currentTime
          .add(Duration(days: DateTime.daysPerWeek - currentTime.weekday));
    } else {
      currentTime = currentTime.add(const Duration(days: 7));
      startOfWeek =
          currentTime.subtract(Duration(days: currentTime.weekday - 1));
      endOfWeek = currentTime
          .add(Duration(days: DateTime.daysPerWeek - currentTime.weekday));
    }
    notifyListeners();
  }
}
