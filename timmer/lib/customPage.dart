import 'package:flutter/material.dart';
import 'circularProgressBar.dart';
import 'dart:async';
import 'Timers.dart';

class CustomPage extends StatefulWidget {
  const CustomPage({super.key, required this.customTimer});
  //final int index;
  final CustomTimer customTimer;
  @override
  State<CustomPage> createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> with TickerProviderStateMixin {
  //late AssetsAudioPlayer audioPlayer;
  late CustomTimer customTimer;
  late Duration leftTime;
  late int currentTimer;

  @override
  void initState() {
    super.initState();
    customTimer = widget.customTimer;
    customTimer.timer1.refreshWidget = refreshWidget;
    customTimer.timer2.refreshWidget = refreshWidget;
    customTimer.timer3.refreshWidget = refreshWidget;
    customTimer.controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    customTimer.computeInternalParams();
    leftTime = customTimer.leftTime;
  }

  void refreshWidget() {
    setState(() {
      currentTimer = customTimer.currentTimer;
      if (customTimer.isResting) {
        leftTime = customTimer.restTimer.leftTime;
        if (!customTimer.restTimer.isStarted) {
          customTimer.isResting = false;
          customTimer.restTimer.isStarted = true;
          customTimer.currentTimer++;
          customTimer.startPauseTimer();
        }
      } else {
        switch (customTimer.currentTimer) {
          case 1:
            leftTime = customTimer.timer1.leftTime;
            if (customTimer.started[0] &
                !(customTimer.timer1.isStarted |
                    customTimer.timer1.isCountDownOn |
                    customTimer.timer1.isRunning)) {
              print("Timer 1 done!");
              customTimer.started[0] = false;
              customTimer.isResting = true;
              // customTimer.currentTimer = 2;
              customTimer.startPauseTimer();
            }
            break;
          case 2:
            leftTime = customTimer.timer2.leftTime;
            if (customTimer.started[1] &
                !(customTimer.timer2.isStarted |
                    customTimer.timer2.isCountDownOn |
                    customTimer.timer2.isRunning)) {
              print("Timer 2 done!");
              customTimer.started[1] = false;
              customTimer.isResting = true;
              // customTimer.currentTimer = 3;
              customTimer.startPauseTimer();
            }
            break;
          case 3:
            leftTime = customTimer.timer3.leftTime;
            if (customTimer.started[2] &
                !(customTimer.timer3.isStarted |
                    customTimer.timer3.isCountDownOn |
                    customTimer.timer3.isRunning)) {
              print("Timer 3 done!");
              customTimer.started[2] = false;
              customTimer.currentTimer = 1;
              stopTimer();
            }
            break;
          default:
        }
      }
      customTimer.isRunning = customTimer.timer1.isRunning |
          customTimer.timer2.isRunning |
          customTimer.timer3.isRunning;
    });
  }

  void startPauseTimer() {
    setState(() {
      customTimer.startPauseTimer();
    });
  }

  void stopTimer() {
    setState(() {
      customTimer.stopTimer();
      leftTime = Duration(seconds: 10);
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
      var hours = strDigits(leftTime.inHours.remainder(24));
      var minutes = strDigits(leftTime.inMinutes.remainder(60));
      var seconds = strDigits(leftTime.inSeconds.remainder(60));

      Icon iconPlay;
      if (!(customTimer.isRunning|customTimer.isResting)) {
        iconPlay = const Icon(Icons.play_arrow_rounded);
      } else {
        iconPlay = const Icon(Icons.pause_rounded);
      }
      return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Text(customTimer.currentTimer.toString()),
                    Center(
                      child: CustomPaint(
                        size: Size(MediaQuery.of(context).size.width - 60,
                            MediaQuery.of(context).size.height / 2),
                        painter: CustomTimerPainter(
                            animation: customTimer.controller,
                            backgroundColor: Colors.grey,
                            color: Colors.orange),
                      ),
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$hours:$minutes:$seconds',
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
          ));
    });
  }
}
