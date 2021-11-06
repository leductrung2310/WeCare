import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarViewModel extends ChangeNotifier {
  String time = 'null';
  void changeCalendar(DateTime dateTime) {
    time = DateFormat('dd-MM-yyyy').format(dateTime);
    notifyListeners();
  }
}
