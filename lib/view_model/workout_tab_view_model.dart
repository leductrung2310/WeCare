import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class WorkoutTabViewModel extends ChangeNotifier {
  int _selectedPage = 0;
  final PageController _pageController = PageController();
  int _getPage = 0;
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 5));

  set selectedPage(newValue) {
    _selectedPage = newValue;
    notifyListeners();
  }

  get selectedPage => _selectedPage;

  set pageController(newValue) {
    _pageController.animateToPage(newValue,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linearToEaseOut);
    notifyListeners();
  }

  get pageController => _pageController;

  set getPage(newValue) {
    _getPage = newValue;
    notifyListeners();
  }

  get getPage => _getPage;

  ConfettiController get confettiController => _confettiController;
}
