import 'package:flutter/material.dart';

class NavigationNotifier extends ChangeNotifier {
  int _page = 0;
  final PageController pageController = PageController(initialPage: 0);

  int get page => _page;

  void setIndex(int index) {
    if (_page == index) return;
    _page = index;
    notifyListeners();
  }
}