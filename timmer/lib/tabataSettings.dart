// ignore_for_file: file_names

import 'displayTile.dart';
import 'package:flutter/material.dart';
import 'tabataPage.dart';
import 'Timers.dart';

class TabataSettings extends StatefulWidget {
  const TabataSettings({super.key, required this.updateSettings});
  final ValueChanged<tabataTimerSettings> updateSettings;

  @override
  State<TabataSettings> createState() => _TabataSettingsState();
}

class _TabataSettingsState extends State<TabataSettings>
    with TickerProviderStateMixin {
  int exercises = 1;
  int sets = 1;
  int onTimeMin = 0;
  int onTimeSec = 0;
  int offTimeMin = 0;
  int offTimeSec = 0;

  void setExersices(int exc) {
    setState(() {
      exercises = exc;
    });
    makeUpdate();
  }

  void setSets(int s) {
    setState(() {
      sets = s;
    });
    makeUpdate();
  }

  void setOnTime(int min, int sec) {
    setState(() {
      onTimeMin = min;
      onTimeSec = sec;
    });
    makeUpdate();
  }

  void setOffTime(int min, int sec) {
    setState(() {
      offTimeMin = min;
      offTimeSec = sec;
    });
    makeUpdate();
  }

  void makeUpdate() {
    widget.updateSettings(tabataTimerSettings(
        exercises: exercises,
        sets: sets,
        onTimeMin: onTimeMin,
        onTimeSec: onTimeSec,
        offTimeMin: offTimeMin,
        offTimeSec: offTimeSec));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Text(
        "Excersises:",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),
      ),
      SizedBox(
        height: 50,
        width: 125,
        child: Center(
          child: ListWheelScrollView.useDelegate(
              onSelectedItemChanged: (value) => {
                    setExersices(value),
                  },
              itemExtent: 50,
              perspective: 0.01,
              diameterRatio: 2,
              physics: const FixedExtentScrollPhysics(),
              controller: FixedExtentScrollController(initialItem: exercises),
              childDelegate: ListWheelChildBuilderDelegate(
                  childCount: 21,
                  builder: (context, index) {
                    return DisplayTile(number: index);
                  })),
        ),
      ),
      const Text(
        "Time ON:",
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
                        setOnTime(value, onTimeSec),
                      },
                  itemExtent: 50,
                  perspective: 0.01,
                  diameterRatio: 2,
                  physics: const FixedExtentScrollPhysics(),
                  controller:
                      FixedExtentScrollController(initialItem: onTimeMin),
                  childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 12,
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
                        setOnTime(onTimeMin, value),
                      },
                  itemExtent: 50,
                  perspective: 0.01,
                  diameterRatio: 2,
                  physics: const FixedExtentScrollPhysics(),
                  controller:
                      FixedExtentScrollController(initialItem: onTimeSec),
                  childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 60,
                      builder: (context, index) {
                        return DisplayTile(number: index);
                      })),
            ),
          ],
        ),
      ),
      const Text(
        "Time OFF:",
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
                        setOffTime(value, offTimeSec),
                      },
                  itemExtent: 50,
                  perspective: 0.01,
                  diameterRatio: 2,
                  physics: const FixedExtentScrollPhysics(),
                  controller:
                      FixedExtentScrollController(initialItem: offTimeMin),
                  childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 12,
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
                        setOffTime(offTimeMin, value),
                      },
                  itemExtent: 50,
                  perspective: 0.01,
                  diameterRatio: 2,
                  physics: const FixedExtentScrollPhysics(),
                  controller:
                      FixedExtentScrollController(initialItem: offTimeSec),
                  childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 60,
                      builder: (context, index) {
                        return DisplayTile(number: index);
                      })),
            ),
          ],
        ),
      ),
      const Text(
        "Sets:",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 30),
      ),
      SizedBox(
        height: 50,
        width: 125,
        child: Center(
          child: ListWheelScrollView.useDelegate(
              onSelectedItemChanged: (value) => {
                    setSets(value),
                  },
              itemExtent: 50,
              perspective: 0.01,
              diameterRatio: 2,
              physics: const FixedExtentScrollPhysics(),
              controller: FixedExtentScrollController(initialItem: sets),
              childDelegate: ListWheelChildBuilderDelegate(
                  childCount: 100,
                  builder: (context, index) {
                    return DisplayTile(number: index);
                  })),
        ),
      ),
    ]));
  }
}
