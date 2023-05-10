// ignore_for_file: file_names

import 'displayTile.dart';
import 'package:flutter/material.dart';
import 'countDownPage.dart';
import 'Timers.dart';

class CountDownSettings extends StatefulWidget {
  const CountDownSettings(
      {super.key, required this.updateSettings});
  final ValueChanged<countDownTimerSettings> updateSettings;

  @override
  State<CountDownSettings> createState() => _CountDownSettingsState();
}

class _CountDownSettingsState extends State<CountDownSettings>
    with TickerProviderStateMixin {
  int timeMin = 0;
  int timeSec = 0;

  @override
  void initState() {
    super.initState();
  }

  void setEvery(int min, int sec) {
    setState(() {
      timeMin = min;
      timeSec = sec;
    });
    widget.updateSettings(countDownTimerSettings(duration: Duration(minutes: min) + Duration(seconds: sec)));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Text(
        "Time:",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),
      ),
      SizedBox(
        height: 50,
        width: 125,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListWheelScrollView.useDelegate(
                  onSelectedItemChanged: (value) => {
                        setEvery(value, timeSec),
                      },
                  itemExtent: 50,
                  perspective: 0.01,
                  diameterRatio: 2,
                  physics: const FixedExtentScrollPhysics(),
                  controller: FixedExtentScrollController(initialItem: timeMin),
                  childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 100,
                      builder: (context, index) {
                        return DisplayTile(number: index);
                      })),
            ),
            const Text(
              ":",
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                  fontSize: 30),
            ),
            Expanded(
              child: ListWheelScrollView.useDelegate(
                  onSelectedItemChanged: (value) => {
                        setEvery(timeMin, value),
                      },
                  itemExtent: 50,
                  perspective: 0.01,
                  diameterRatio: 2,
                  physics: const FixedExtentScrollPhysics(),
                  controller: FixedExtentScrollController(initialItem: timeSec),
                  childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 60,
                      builder: (context, index) {
                        return DisplayTile(number: index);
                      })),
            ),
          ],
        ),
      ),
    ]));
  }
}
