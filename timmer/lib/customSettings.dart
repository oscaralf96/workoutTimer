import 'package:flutter/material.dart';
import 'package:timmer/emomSettings.dart';
import 'package:timmer/tabataSettings.dart';
import 'Timers.dart';
import 'countDownSettings.dart';
import 'displayTile.dart';

const List<String> list = <String>['Count Down', 'EMOM', 'Tabata'];

class DialogExample extends StatelessWidget {
  const DialogExample({super.key, required this.timerType});

  final int timerType;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('AlertDialog Title'),
          content: const Text('AlertDialog description'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      child: const Text('Config'),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});
  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text('Select Timer Type'),
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward, color: Colors.white),
      elevation: 16,
      style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
      underline: Container(
        height: 2,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class CustomSettings extends StatefulWidget {
  const CustomSettings({super.key, required this.updateSettings});
  final ValueChanged<CustomTimer> updateSettings;
  @override
  State<CustomSettings> createState() => _CustomSettingsState();
}

class _CustomSettingsState extends State<CustomSettings>
    with TickerProviderStateMixin {
  String? timer1Type, timer2Type, timer3Type;
  dynamic timer1, timer2, timer3;
  dynamic timer1Settings, timer2Settings, timer3Settings;
  int restSec = 0, restMin = 0;
  Duration restBetweenTimers = Duration(seconds: 0);

  void updateTimer1Settings(dynamic settings) {
    setState(() {
      timer1.settings = settings;
      widget.updateSettings(CustomTimer(
          timer1: timer1,
          timer2: timer2,
          timer3: timer3,
          restBetweenTimers: restBetweenTimers));
    });
  }

  void updateTimer2Settings(dynamic settings) {
    setState(() {
      timer2.settings = settings;
      widget.updateSettings(CustomTimer(
          timer1: timer1,
          timer2: timer2,
          timer3: timer3,
          restBetweenTimers: restBetweenTimers));
    });
  }

  void updateTimer3Settings(dynamic settings) {
    setState(() {
      timer3.settings = settings;
      widget.updateSettings(CustomTimer(
          timer1: timer1,
          timer2: timer2,
          timer3: timer3,
          restBetweenTimers: restBetweenTimers));
    });
  }

  dynamic createTimer(String timerType) {
    switch (timerType) {
      case "Count Down":
        return CountdownTimer();
      case "EMOM":
        return EmomTimer();
      case "Tabata":
        return TabataTimer();
    }
  }

  dynamic createSettings(int timerNum, String timerType) {
    dynamic updateFunction;

    switch (timerNum) {
      case 1:
        updateFunction = updateTimer1Settings;
        break;
      case 2:
        updateFunction = updateTimer2Settings;
        break;
      case 3:
        updateFunction = updateTimer3Settings;
        break;
    }

    switch (timerType) {
      case "Count Down":
        return CountDownSettings(
          updateSettings: updateFunction,
        );
      case "EMOM":
        return EmomSettings(
          updateSettings: updateFunction,
        );
      case "Tabata":
        return TabataSettings(
          updateSettings: updateFunction,
        );
    }
  }

  void setTimerType(int timerNum, String? newType) {
    setState(() {
      switch (timerNum) {
        case 1:
          timer1Type = newType;
          timer1 = createTimer(newType!);
          timer1Settings = createSettings(timerNum, newType);
          // print("----------timer 1 values: -------------");
          // print(timer1);
          break;
        case 2:
          timer2Type = newType;
          timer2 = createTimer(newType!);
          timer2Settings = createSettings(timerNum, newType);
          // print("----------timer 2 values: -------------");
          // print(timer2);
          break;
        case 3:
          timer3Type = newType;
          timer3 = createTimer(newType!);
          timer3Settings = createSettings(timerNum, newType);
          // print("----------timer 3 values: -------------");
          // print(timer3);
          break;
      }
    });
  }

  void setRestBetweenTimers(int sec, min) {
    setState(() {
      restSec = sec;
      restMin = min;
      restBetweenTimers = Duration(seconds: min * 60 + sec);
      widget.updateSettings(CustomTimer(
          timer1: timer1,
          timer2: timer2,
          timer3: timer3,
          restBetweenTimers: restBetweenTimers));
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Custom Settings Page"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    hint: Text('Select Timer Type'),
                    value: timer1Type,
                    onChanged: (String? newValue) {
                      setTimerType(1, newValue);
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                        onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Timer Configuration'),
                                content: timer1Settings,
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            ),
                        child: Text("Config")),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    hint: Text('Select Timer Type'),
                    value: timer2Type,
                    onChanged: (String? newValue) {
                      setTimerType(2, newValue);
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                        onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Timer Configuration'),
                                content: timer2Settings,
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            ),
                        child: Text("Config")),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton<String>(
                    hint: Text('Select Timer Type'),
                    value: timer3Type,
                    onChanged: (String? newValue) {
                      setTimerType(3, newValue);
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                        onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Timer Configuration'),
                                content: timer3Settings,
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            ),
                        child: Text("Config")),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Rest between timers: "),
                  SizedBox(
                    width: 125,
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          child: ListWheelScrollView.useDelegate(
                              onSelectedItemChanged: (value) =>
                                  {setRestBetweenTimers(restSec, value)},
                              itemExtent: 50,
                              perspective: 0.01,
                              diameterRatio: 2,
                              physics: const FixedExtentScrollPhysics(),
                              controller: FixedExtentScrollController(
                                  initialItem: restMin),
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
                              onSelectedItemChanged: (value) =>
                                  {setRestBetweenTimers(value, restMin)},
                              itemExtent: 50,
                              perspective: 0.01,
                              diameterRatio: 2,
                              physics: const FixedExtentScrollPhysics(),
                              controller: FixedExtentScrollController(
                                  initialItem: restSec),
                              childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: 60,
                                  builder: (context, index) {
                                    return DisplayTile(number: index);
                                  })),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
