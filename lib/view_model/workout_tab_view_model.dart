import 'package:flutter/material.dart';

class WorkoutTabViewModel extends ChangeNotifier {
  int _selectedPage = 0;
  final PageController _pageController = PageController();

  set selectedPage(newValue) {
    _selectedPage = newValue;
    notifyListeners();
  }

  get selectedPage => _selectedPage;

  set pageController(newValue) {
    _pageController.animateToPage(newValue,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn);
    notifyListeners();
  }

  get pageController => _pageController;
}
