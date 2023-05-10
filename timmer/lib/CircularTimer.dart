import 'package:flutter/material.dart';
// import 'package:assets_audio_player/assets_audio_player.dart';
import 'dart:async';
import 'circularProgressBar.dart';
import 'displayTile.dart';

class CircularTimer extends StatefulWidget {
  const CircularTimer(
      {super.key,
      required this.duration,
      required this.index,
      required this.autoPlay});
  final int index;
  final int duration;
  final bool autoPlay;
  @override
  State<CircularTimer> createState() => _CircularTimerState();
}

class _CircularTimerState extends State<CircularTimer>
    with TickerProviderStateMixin {
  AnimationController? controller;
  //late AssetsAudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    defaultDuration = Duration(seconds: widget.duration);
    myDuration = Duration(seconds: widget.duration);
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: myDuration!.inSeconds + 1),
    );
    if (widget.autoPlay) {
      startPauseTimer();
    }
  }

  Timer? countDownTimer;
  Duration? defaultDuration;
  Duration? myDuration;
  bool _isRunning = false;

  int excercisesNum = 0;

  void setDuration(Duration newDuration) {
    // print(newDuration);
    setState(() {
      myDuration = newDuration;
      defaultDuration = newDuration;
    });
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      var seconds = myDuration!.inSeconds - reduceSecondsBy;
      // print(myDuration);
      if (seconds < 0) {
        stopTimer();
        _isRunning = false;
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  void startPauseTimer() {
    setState(() {
      controller!.duration = Duration(seconds: myDuration!.inSeconds + 1);
      controller!
          .reverse(from: myDuration!.inSeconds / (defaultDuration!.inSeconds));
      if (!_isRunning) {
        _isRunning = true;
        countDownTimer =
            Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
      } else {
        setState(() {
          countDownTimer!.cancel();
          controller!.stop();
          _isRunning = false;
        });
      }
    });
  }

  void stopTimer() {
    if (_isRunning) {
      setState(() {
        myDuration = defaultDuration;
        countDownTimer!.cancel();
        controller!.reset();
        controller!.stop();
        _isRunning = false;
      });
    }
  }

  String strDigits(int n) => n.toString().padLeft(2, '0');

  @override
  void dispose() {
    // audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.index.toString());
    var hours = strDigits(myDuration!.inHours.remainder(24));
    var minutes = strDigits(myDuration!.inMinutes.remainder(60));
    var seconds = strDigits(myDuration!.inSeconds.remainder(60));

    var newHours = 0;
    var newMinutes = 0;
    var newSeconds = 0;

    Icon iconPlay;
    if (!_isRunning) {
      iconPlay = const Icon(Icons.play_arrow_rounded);
    } else {
      iconPlay = const Icon(Icons.pause_rounded);
    }

/*     audioPlayer = AssetsAudioPlayer.newPlayer();
    audioPlayer.open(
      Audio('audios/countdown.mp3'),
      autoStart: true,
    );
    audioPlayer.playOrPause(); */

    return LayoutBuilder(builder: (context, constraints) {
      // print(_selectedIndex);

      return Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: CustomPaint(
                    size: Size(MediaQuery.of(context).size.width - 60,
                        MediaQuery.of(context).size.height / 2),
                    painter: CustomTimerPainter(
                        animation: controller!,
                        backgroundColor: Colors.grey,
                        color: Colors.orange),
                  ),
                ),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (!_isRunning) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      // title: const Text('AlertDialog Title'),
                                      content: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: const [
                                              Text("hours"),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text("minutes"),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text("seconds"),
                                            ],
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            height: 200,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: ListWheelScrollView
                                                      .useDelegate(
                                                          onSelectedItemChanged:
                                                              (value) => {
                                                                    newHours =
                                                                        value,
                                                                  },
                                                          itemExtent: 50,
                                                          perspective: 0.01,
                                                          diameterRatio: 2,
                                                          physics:
                                                              const FixedExtentScrollPhysics(),
                                                          childDelegate:
                                                              ListWheelChildBuilderDelegate(
                                                                  childCount:
                                                                      24,
                                                                  builder:
                                                                      (context,
                                                                          index) {
                                                                    return DisplayTile(
                                                                        number:
                                                                            index);
                                                                  })),
                                                ),
                                                Expanded(
                                                  child: ListWheelScrollView
                                                      .useDelegate(
                                                          onSelectedItemChanged:
                                                              (value) => {
                                                                    newMinutes =
                                                                        value,
                                                                  },
                                                          itemExtent: 50,
                                                          perspective: 0.01,
                                                          diameterRatio: 2,
                                                          physics:
                                                              const FixedExtentScrollPhysics(),
                                                          childDelegate:
                                                              ListWheelChildBuilderDelegate(
                                                                  childCount:
                                                                      60,
                                                                  builder:
                                                                      (context,
                                                                          index) {
                                                                    return DisplayTile(
                                                                        number:
                                                                            index);
                                                                  })),
                                                ),
                                                Expanded(
                                                  child: ListWheelScrollView
                                                      .useDelegate(
                                                          onSelectedItemChanged:
                                                              (value) => {
                                                                    newSeconds =
                                                                        value,
                                                                  },
                                                          itemExtent: 50,
                                                          perspective: 0.01,
                                                          diameterRatio: 2,
                                                          physics:
                                                              const FixedExtentScrollPhysics(),
                                                          childDelegate:
                                                              ListWheelChildBuilderDelegate(
                                                                  childCount:
                                                                      60,
                                                                  builder:
                                                                      (context,
                                                                          index) {
                                                                    return DisplayTile(
                                                                        number:
                                                                            index);
                                                                  })),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed: () => {
                                            setDuration(Duration(
                                                hours: newHours,
                                                minutes: newMinutes,
                                                seconds: newSeconds)),
                                            Navigator.pop(context, 'OK')
                                          },
                                          child: const Text("OK"),
                                        ),
                                      ],
                                    ));
                          }
                        },
                        child: Text(
                          '$hours:$minutes:$seconds',
                          style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontSize: 60),
                        ),
                      )
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
      );
    });
  }
}
