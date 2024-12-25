import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_app_provider/timer/provider/time_provider.dart';

class CountdownTimer extends StatelessWidget {
  const CountdownTimer({super.key});

  @override
  Widget build(BuildContext context) {
    final timeProvider = Provider.of<TimeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: const Text(
          "CountDown Timer",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 280,
                  width: 280,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black12,
                    value: timeProvider.initialTime > 0
                        ? timeProvider.RemainingTime / timeProvider.initialTime
                        : 0,
                    strokeWidth: 8,
                  ),
                ),
                GestureDetector(
                  onTap: ()=>_showTimePicker(context,timeProvider),
                  child: Text(
                    _formatTime(timeProvider.RemainingTime),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: timeProvider.isRunning
                      ? timeProvider.pauseTimer
                      : timeProvider.startTime,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: Icon(
                      timeProvider.isRunning ? Icons.pause : Icons.play_arrow,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: timeProvider.resetTimer,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: const Icon(
                      Icons.stop,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

   void _showTimePicker(BuildContext context, TimeProvider timerProvider) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.white,
          height: 300,
          child: CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hms,
            initialTimerDuration:
                Duration(seconds: timerProvider.RemainingTime),
            onTimerDurationChanged: (Duration newDuration) {
              if (newDuration.inSeconds > 0) {
                timerProvider.setTime(newDuration.inSeconds);
              }
            },
          ),
        );
      },
    );
  }

  String _formatTime(int totalSecond) {
    int hours = totalSecond ~/ 3600;
    int minutes = (totalSecond % 3600) ~/ 60;

    int seconds = totalSecond % 60;

    return "${hours.toString().padLeft(2, "0")} :${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
  }
}
