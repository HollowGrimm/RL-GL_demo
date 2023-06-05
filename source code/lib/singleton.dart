import 'package:flutter/material.dart';

class Singleton extends ChangeNotifier {
  static final Singleton _instance = Singleton._internal();

  // passes the instantiation to the _instance object
  factory Singleton() => _instance;

  // initialize our variables
  Singleton._internal();

  int win = 0, loss = 0;

  void winScore(int point) {
    win += point;
    notifyListeners();
  }

  void lossScore(int point) {
    loss += point;
    notifyListeners();
  }
}
