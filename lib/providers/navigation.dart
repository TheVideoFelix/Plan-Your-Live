import 'package:flutter/material.dart';

class NavigationNotifier extends ChangeNotifier {
  int _page = 0;
  int _previousPage = 0;
  final PageController pageController = PageController(initialPage: 0);

  int get page => _page;
  int get previousPage => _previousPage;

  void setIndex(int index) {
    if (_page == index) return;
    _page = index;
    notifyListeners();
  }

  void jumpToPage(int pageIndex) {
    _previousPage = pageController.page?.round() ?? 0;
    notifyListeners();
    pageController.jumpToPage(pageIndex);
  }
}