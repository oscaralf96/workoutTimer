import 'package:flutter/material.dart';
import 'package:timmer/Timers.dart';
import 'circularProgressBar.dart';
import 'dart:async';
import 'Timers.dart';

class TabataPage extends StatefulWidget {
  const TabataPage({super.key, required this.tabataTimer});
  final TabataTimer tabataTimer;
  @override
  State<TabataPage> createState() => _TabataPageState();
}

class _TabataPageState extends State<TabataPage> with TickerProviderStateMixin {
  late TabataTimer tabataTimer;
  late Duration leftTime;

  @override
  void initState() {
    super.initState();
    tabataTimer = widget.tabataTimer;
    tabataTimer.computeInternalParams();
    leftTime = tabataTimer.leftTime;
    tabataTimer.refreshWidget = refreshWidget;
    tabataTimer.controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: tabataTimer.onDuration.inSeconds + 1),
    );
  }

  void refreshWidget() {
    setState(() {
      leftTime = tabataTimer.leftTime;
    });
  }

  void startPauseTimer() {
    setState(() {
      tabataTimer.configCountDown();
      tabataTimer.startPauseTimer();
    });
  }

  void stopTimer() {
    setState(() {
      tabataTimer.stopTimer();
    });
  }

  String strDigits(int n) => n.toString().padLeft(2, '0');

  @override
  void dispose() {
    // audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // print(widget.index.toString());
      var minutes = strDigits(leftTime.inMinutes.remainder(60));
      var seconds = strDigits(leftTime.inSeconds.remainder(60));

      Icon iconPlay;
      if (!tabataTimer.isRunning) {
        iconPlay = const Icon(Icons.play_arrow_rounded);
      } else {
        iconPlay = const Icon(Icons.pause_rounded);
      }

      return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(
                children: [
                  const Text("Exercises: "),
                  Text('${tabataTimer.currentExercise}/${tabataTimer.exercises}'),
                ],
              ),
              const SizedBox(
                width: 50,
              ),
              Column(
                children: [
                  const Text("Sets: "),
                  Text('${tabataTimer.currentSet}/${tabataTimer.sets}'),
                ],
              ),
            ]),
            Expanded(
              child: Stack(
                children: [
                  Center(
                    child: CustomPaint(
                      size: Size(MediaQuery.of(context).size.width - 60,
                          MediaQuery.of(context).size.height / 2),
                      painter: CustomTimerPainter(
                          animation: tabataTimer.controller,
                          backgroundColor: Colors.grey,
                          color: tabataTimer.progressBarColor),
                    ),
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$minutes:$seconds',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black,
                                  fontSize: 60),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ]),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 50,
                  hoverColor: Colors.white30,
                  highlightColor: Colors.white,
                  color: Colors.black,
                  icon: iconPlay,
                  onPressed: () {
                    startPauseTimer();
                  },
                ),
                IconButton(
                  iconSize: 50,
                  hoverColor: Colors.white30,
                  highlightColor: Colors.white,
                  color: Colors.black,
                  icon: const Icon(Icons.stop_rounded),
                  onPressed: () {
                    stopTimer();
                  },
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
              child: Row(
                children: const [
                  Text("..."),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
