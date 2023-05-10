import 'package:flutter/material.dart';
import 'dart:async';
import 'circularProgressBar.dart';
import 'Timers.dart';

class CountDownPage extends StatefulWidget {
  const CountDownPage({super.key, required this.countdownTimer});
  final CountdownTimer countdownTimer;
  @override
  State<CountDownPage> createState() => _CountDownPageState();
}

class _CountDownPageState extends State<CountDownPage>
    with TickerProviderStateMixin {
  late CountdownTimer countDownTimer;
  late Duration leftTime;

  @override
  void initState() {
    super.initState();
    countDownTimer = widget.countdownTimer;
    countDownTimer.leftTime = widget.countdownTimer.settings!.duration;
    leftTime = countDownTimer.leftTime;
    countDownTimer.refreshWidget = refreshWidget;
    countDownTimer.controller = AnimationController(
      vsync: this,
      duration: Duration(
          seconds: widget.countdownTimer.settings!.duration.inSeconds + 1),
    );
  }

  void refreshWidget() {
    setState(() {
      leftTime = countDownTimer.leftTime;
    });
  }

  void startPauseTimer() {
    setState(() {
      countDownTimer.configCountDown();
      countDownTimer.startPauseTimer();
    });
  }

  void stopTimer() {
    setState(() {
      countDownTimer.stopTimer();
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
      var hours = strDigits(countDownTimer.leftTime.inHours.remainder(24));
      var minutes = strDigits(countDownTimer.leftTime.inMinutes.remainder(60));
      var seconds = strDigits(countDownTimer.leftTime.inSeconds.remainder(60));

      Icon iconPlay;
      if (!countDownTimer.isRunning) {
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
                    Center(
                      child: CustomPaint(
                        size: Size(MediaQuery.of(context).size.width - 60,
                            MediaQuery.of(context).size.height / 2),
                        painter: CustomTimerPainter(
                            animation: countDownTimer.controller,
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
