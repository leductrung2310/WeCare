import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarViewModel extends ChangeNotifier {
  String time = DateFormat('dd-MM-yyyy').format(DateTime.now());
  void changeCalendar(DateTime dateTime) {
    time = DateFormat('dd-MM-yyyy').format(dateTime);
    notifyListeners();
  }
}
