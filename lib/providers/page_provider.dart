import 'package:flutter/material.dart';

class PageProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void resetIndex() {
    _currentIndex = 0;
    notifyListeners();
  }
}
