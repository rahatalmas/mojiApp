import 'package:flutter/material.dart';

class ActionStatusProvider with ChangeNotifier {
  bool _actionStatus = false;

  bool get actionInfo => _actionStatus;

  void turnActionStatusOn() {
    _actionStatus = true;
    notifyListeners();
  }

  void turnActionStatusOff() {
    _actionStatus = false;
    notifyListeners();
  }
}