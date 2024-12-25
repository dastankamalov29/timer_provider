import 'dart:async';

import 'package:flutter/material.dart';

class TimeProvider extends ChangeNotifier {
  int _remainingTime = 60;
  int _initialTime = 60;
  Timer? _timer;

  bool _isRunning = false;

  int get RemainingTime => _remainingTime;
  int get initialTime => _initialTime;
  bool get isRunning => _isRunning;

  //starts the timer and updates remainit time every seconds

  void startTime() {
    if (_timer != null) return;
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        _remainingTime--;
        notifyListeners();
      } else {
        _timer?.cancel();
        _timer = null;
        _remainingTime = _initialTime; //Reset the initial time
        _isRunning = false;
        notifyListeners();
      }
    });
  }

  //pause the timer

  void pauseTimer() {
    _timer?.cancel();
    _timer = null;
    _isRunning = false;
    notifyListeners();
  }

  //reset timer
  void resetTimer() {
    _timer?.cancel();
    _timer = null;
    _remainingTime = _initialTime;
    _isRunning = false;
    notifyListeners();
  }

   void setTime(int seconds) {
    _remainingTime = seconds;
    _initialTime = seconds;
    notifyListeners();
  }
}
