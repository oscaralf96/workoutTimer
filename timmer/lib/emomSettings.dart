// ignore_for_file: file_names

import 'displayTile.dart';
import 'package:flutter/material.dart';
import 'emomPage.dart';
import 'Timers.dart';

class EmomSettings extends StatefulWidget {
  const EmomSettings(
      {super.key, required this.updateSettings});
  final ValueChanged<emomTimerSettings> updateSettings;

  @override
  State<EmomSettings> createState() => _EmomSettingsState();
}

class _EmomSettingsState extends State<EmomSettings>
    with TickerProviderStateMixin {
  int everyTimeMin = 0;
  int everyTimeSec = 0;
  int forTime = 0;
  int forTimeOptions = 1;

  void setEvery(int min, int sec, int time) {
    setState(() {
      if (forTime == time && forTime != 0) {
        forTime =
            (forTime ~/ (everyTimeMin * 60 + everyTimeSec)) * (min * 60 + sec);
      } else {
        forTime = time * (everyTimeMin * 60 + everyTimeSec);
      }
      everyTimeMin = min;
      everyTimeSec = sec;
      if (min > 0 || sec > 0) {
        forTimeOptions = (100 * 60) ~/ (min * 60 + sec) + 1;
      }
    });
    widget.updateSettings(emomTimerSettings(
        everyTimeMin: min, everyTimeSec: sec, forTime: forTime));
  }

  @override
  Widget build(BuildContext context) {
    //print(forTime);
    return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Text(
        "Every:",
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
                        setEvery(value, everyTimeSec, forTime),
                      },
                  itemExtent: 50,
                  perspective: 0.01,
                  diameterRatio: 2,
                  physics: const FixedExtentScrollPhysics(),
                  controller:
                      FixedExtentScrollController(initialItem: everyTimeMin),
                  childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 13,
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
                        setEvery(everyTimeMin, value * 30, forTime),
                      },
                  itemExtent: 50,
                  perspective: 0.01,
                  diameterRatio: 2,
                  physics: const FixedExtentScrollPhysics(),
                  controller:
                      FixedExtentScrollController(initialItem: everyTimeSec),
                  childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 2,
                      builder: (context, index) {
                        index = 30 * index;
                        return DisplayTile(number: index);
                      })),
            ),
          ],
        ),
      ),
      const Text(
        "For:",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),
      ),
      SizedBox(
        height: 50,
        width: double.infinity,
        child: ListWheelScrollView.useDelegate(
            onSelectedItemChanged: (value) => {
                  setEvery(everyTimeMin, everyTimeSec, value),
                },
            itemExtent: 50,
            perspective: 0.01,
            diameterRatio: 2,
            physics: const FixedExtentScrollPhysics(),
            controller: FixedExtentScrollController(initialItem: forTime),
            childDelegate: ListWheelChildBuilderDelegate(
                childCount: forTimeOptions,
                builder: (context, index) {
                  int displayMin =
                      index * (everyTimeMin * 60 + everyTimeSec) ~/ 60;
                  int displaySec =
                      index * (everyTimeMin * 60 + everyTimeSec) % 60;
                  // print('$index:$displayMin:$displaySec');
                  // print('$forTime');
                  // if (forTime != 0){
                  //   print(forTime ~/ (everyTimeMin * 60 + everyTimeSec));
                  // }
                  // print('--------------------------------');
                  return DisplayTileDouble(
                    number1: displayMin,
                    number2: displaySec,
                  );
                })),
      ),
    ]));
  }
}
