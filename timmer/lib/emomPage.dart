import 'package:flutter/material.dart';
import 'circularProgressBar.dart';
import 'dart:async';
import 'Timers.dart';

class EmomPage extends StatefulWidget {
  const EmomPage({super.key, required this.emomTimer});
  //final int index;
  final EmomTimer emomTimer;
  @override
  State<EmomPage> createState() => _EmomPageState();
}

class _EmomPageState extends State<EmomPage> with TickerProviderStateMixin {
  //late AssetsAudioPlayer audioPlayer;
  late EmomTimer emomTimer;
  late Duration leftTime;

  @override
  void initState() {
    super.initState();
    emomTimer = widget.emomTimer;
    emomTimer.computeInternalParams();
    leftTime = emomTimer.leftTime;
    emomTimer.refreshWidget = refreshWidget;
    emomTimer.controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: emomTimer.roundDuration.inSeconds + 1),
    );
  }

  void refreshWidget() {
    setState(() {
      leftTime = emomTimer.leftTime;
    });
  }

  void startPauseTimer() {
    setState(() {
      emomTimer.configCountDown();
      emomTimer.startPauseTimer();
    });
  }

  void stopTimer() {
    setState(() {
      emomTimer.stopTimer();
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
      if (!emomTimer.isRunning) {
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
                      child: Column(children: [
                        const Text("Rounds: "),
                        Text('${emomTimer.currentRound}/${emomTimer.rounds}')
                      ]),
                    ),
                    Center(
                      child: CustomPaint(
                        size: Size(MediaQuery.of(context).size.width - 60,
                            MediaQuery.of(context).size.height / 2),
                        painter: CustomTimerPainter(
                            animation: emomTimer.controller,
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
          ));
    });
  }
}
