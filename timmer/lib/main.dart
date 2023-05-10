import 'package:flutter/material.dart';
import 'package:timmer/emomPage.dart';
import 'package:timmer/tabataPage.dart';
import 'emomSettings.dart';
import 'countDownSettings.dart';
import 'tabataSettings.dart';
import 'customSettings.dart';
import 'Timers.dart';
import 'countDownPage.dart';
import 'customPage.dart';

const Color backgroudColor = Colors.white;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout timer',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late countDownTimerSettings countDownsettings;
  late emomTimerSettings emomSettings;
  late tabataTimerSettings tabataSettings;
  late CustomTimer customTimer;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _updateCountDownSettings(countDownTimerSettings settings) {
    setState(() {
      countDownsettings = settings;
    });
  }

  void _updateEmomSettings(emomTimerSettings settings) {
    setState(() {
      emomSettings = settings;
    });
  }

  void _updateTabataSettings(tabataTimerSettings settings) {
    setState(() {
      tabataSettings = settings;
    });
  }

  void _updateCustomSettings(CustomTimer newCustomTimer) {
    setState(() {
      customTimer = newCustomTimer;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (_selectedIndex) {
      case 0:
        page = CountDownSettings(
          updateSettings: _updateCountDownSettings,
        );
        break;
      case 1:
        page = EmomSettings(updateSettings: _updateEmomSettings);
        break;
      case 2:
        page = TabataSettings(updateSettings: _updateTabataSettings);
        break;
      case 3:
        page = CustomSettings(updateSettings: _updateCustomSettings);
        break;
      default:
        throw UnimplementedError('no widget for $_selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      // print(_selectedIndex);

      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Countdown",
              backgroundColor: Color.fromARGB(255, 48, 134, 150),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Emom',
              backgroundColor: Color.fromARGB(255, 33, 105, 138),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Tabata',
              backgroundColor: Color.fromARGB(255, 83, 64, 255),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Custom',
              backgroundColor: Color.fromARGB(255, 142, 26, 196),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
        body: Container(
          color: Theme.of(context).colorScheme.primary,
          child: Column(
            children: [
              Expanded(flex: 8, child: page),
              Expanded(
                  flex: 2,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        switch (_selectedIndex) {
                          case 0:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CountDownPage(
                                        countdownTimer: CountdownTimer(
                                            settings: countDownsettings),
                                      )),
                            );
                            break;
                          case 1:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EmomPage(
                                        emomTimer:
                                            EmomTimer(settings: emomSettings),
                                      )),
                            );
                            break;
                          case 2:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TabataPage(
                                        tabataTimer: TabataTimer(
                                            settings: tabataSettings),
                                      )),
                            );
                            break;
                          case 3:
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CustomPage(customTimer: customTimer)),
                            );
                            break;
                          default:
                            throw UnimplementedError(
                                'no widget for $_selectedIndex');
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Start",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ), //page
      );
    });
  }
}
