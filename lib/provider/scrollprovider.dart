import 'package:flutter/material.dart';

class ScrollProvider extends ChangeNotifier {
  bool _isBottom = false;

  bool get isBottom => _isBottom;

  void setIsBottom(bool value) {
    if (_isBottom != value) {
      _isBottom = value;
      notifyListeners(); 
    }
  }
}