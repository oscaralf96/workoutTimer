import 'package:flutter/material.dart';
import 'dart:async';

import 'package:timmer/countDownSettings.dart';

class countDownTimerSettings {
  countDownTimerSettings({required this.duration});

  Duration duration;
}

class emomTimerSettings {
  emomTimerSettings(
      {required this.everyTimeMin,
      required this.everyTimeSec,
      required this.forTime});

  int everyTimeMin;
  int everyTimeSec;
  int forTime;
}

class CountdownTimer {
  CountdownTimer({this.settings});
  countDownTimerSettings? settings;

  late AnimationController controller;
  late Timer secondsTimer;
  late Duration leftTime;
  late Function refreshWidget;
  bool isRunning = false, isStarted = false, isCountDownOn = false;

  void computeInternalParams() {}

  void reverseController(
      Duration descendingDuration, Duration referenceDuration) {
    controller.duration = Duration(seconds: descendingDuration.inSeconds + 1);
    controller.reverse(
        from: descendingDuration.inSeconds / (referenceDuration.inSeconds));
  }

  void stopTimer() {
    if (isRunning) {
      leftTime = settings!.duration;
      secondsTimer.cancel();
      controller.reset();
      controller.stop();
      isRunning = false;
      isStarted = false;
      isCountDownOn = false;
      refreshWidget();
    }
  }

  void setCountDown() {
    print("estoy contando :)");
    if (leftTime.inSeconds - 1 < 0) {
      if (!isStarted && isCountDownOn) {
        isStarted = true;
        isCountDownOn = false;
        leftTime = settings!.duration;
        controller.duration = Duration(seconds: leftTime.inSeconds + 1);
        controller.reverse(
            from: leftTime.inSeconds / (settings!.duration.inSeconds));
      } else {
        stopTimer();
      }
    } else {
      leftTime = Duration(seconds: leftTime.inSeconds - 1);
    }
    refreshWidget();
  }

  void configCountDown() {
    if (!isStarted) {
      if (!isCountDownOn) {
        isCountDownOn = true;
        leftTime = const Duration(seconds: 10);
      } else {
        if (isCountDownOn) {
          isCountDownOn = false;
        }
      }
    }
  }

  void startPauseTimer() {
    if (isCountDownOn) {
      reverseController(leftTime, const Duration(seconds: 10));
    } else {
      reverseController(leftTime, settings!.duration);
    }
    if (!isRunning) {
      isRunning = true;
      secondsTimer =
          Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
    } else {
      secondsTimer.cancel();
      controller.stop();
      isRunning = false;
    }
  }
}

class EmomTimer {
  EmomTimer({this.settings});
  emomTimerSettings? settings;

  late AnimationController controller;
  late Timer secondsTimer;
  late Duration leftTime, roundDuration;
  late Function refreshWidget;
  late int rounds;
  int currentRound = 1;
  bool isRunning = false, isStarted = false, isCountDownOn = false;

  void computeInternalParams() {
    roundDuration =
        Duration(seconds: settings!.everyTimeMin * 60 + settings!.everyTimeSec);
    leftTime = Duration(seconds: settings!.forTime);
    rounds = settings!.forTime ~/
        (settings!.everyTimeMin * 60 + settings!.everyTimeSec);
  }

  void reverseController(
      Duration descendingDuration, Duration referenceDuration) {
    controller.duration = Duration(seconds: descendingDuration.inSeconds + 1);
    controller.reverse(
        from: descendingDuration.inSeconds / (referenceDuration.inSeconds));
  }

  void stopTimer() {
    if (isRunning) {
      leftTime = Duration(seconds: settings!.forTime);
      secondsTimer.cancel();
      controller.reset();
      controller.stop();
      currentRound = 1;
      isRunning = false;
      isStarted = false;
      isCountDownOn = false;
    }
    refreshWidget();
  }

  void setCountDown() {
    if (leftTime.inSeconds - 1 < 0) {
      if (!isStarted && isCountDownOn) {
        isStarted = true;
        isCountDownOn = false;
        leftTime = roundDuration;
        controller.duration = Duration(seconds: leftTime.inSeconds + 1);
        controller.reverse(
            from: leftTime.inSeconds / (roundDuration.inSeconds));
      } else {
        if (currentRound == rounds) {
          stopTimer();
        } else {
          currentRound++;
          leftTime = roundDuration;
          reverseController(leftTime, roundDuration);
        }
      }
    } else {
      leftTime = Duration(seconds: leftTime.inSeconds - 1);
    }
    refreshWidget();
  }

  void configCountDown() {
    if (!isStarted) {
      if (!isCountDownOn) {
        isCountDownOn = true;
        leftTime = const Duration(seconds: 10);
      } else {
        if (isCountDownOn) {
          isCountDownOn = false;
        }
      }
    }
    refreshWidget();
  }

  void startPauseTimer() {
    if (isCountDownOn) {
      reverseController(leftTime, const Duration(seconds: 10));
    } else {
      reverseController(leftTime, Duration(seconds: settings!.forTime));
    }
    if (!isRunning) {
      isRunning = true;
      secondsTimer =
          Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
    } else {
      secondsTimer.cancel();
      controller.stop();
      isRunning = false;
    }
  }
}

class tabataTimerSettings {
  tabataTimerSettings(
      {required this.exercises,
      required this.sets,
      required this.onTimeMin,
      required this.onTimeSec,
      required this.offTimeMin,
      required this.offTimeSec});

  int exercises;
  int sets;
  int onTimeMin;
  int onTimeSec;
  int offTimeMin;
  int offTimeSec;
}

class TabataTimer {
  TabataTimer({this.settings});
  tabataTimerSettings? settings;

  late AnimationController controller;
  late Timer secondsTimer;
  late Duration leftTime, onDuration, offDuration, defaultDuration;
  late Function refreshWidget;
  int currentExercise = 1, currentSet = 1, exercises = 0, sets = 0;
  bool isRunning = false,
      isStarted = false,
      isCountDownOn = false,
      isOnCycle = true;
  Color progressBarColor = Colors.orange;

  void computeInternalParams() {
    onDuration =
        Duration(seconds: settings!.onTimeMin * 60 + settings!.onTimeSec);
    offDuration =
        Duration(seconds: settings!.offTimeMin * 60 + settings!.offTimeSec);
    defaultDuration = onDuration;
    leftTime = defaultDuration;
    exercises = settings!.exercises;
    sets = settings!.sets;
  }

  void reverseController(
      Duration descendingDuration, Duration referenceDuration) {
    controller.duration = Duration(seconds: descendingDuration.inSeconds + 1);
    controller.reverse(
        from: descendingDuration.inSeconds / (referenceDuration.inSeconds));
  }

  void stopTimer() {
    if (isRunning) {
      leftTime = defaultDuration;
      secondsTimer.cancel();
      controller.reset();
      controller.stop();
      currentExercise = 1;
      currentSet = 1;
      isRunning = false;
      isStarted = false;
    }
  }

  void setCountDown() {
    if (leftTime.inSeconds - 1 < 0) {
      if (!isStarted && isCountDownOn) {
        isStarted = true;
        isCountDownOn = false;
        leftTime = defaultDuration;
        controller.duration = Duration(seconds: leftTime.inSeconds + 1);
        controller.reverse(
            from: leftTime.inSeconds / (defaultDuration.inSeconds));
        leftTime = onDuration;
        progressBarColor = Colors.orange;
      } else {
        if (currentSet == sets && currentExercise == exercises && !isOnCycle) {
          stopTimer();
        } else {
          if (isOnCycle) {
            isOnCycle = false;
            leftTime = offDuration;
            progressBarColor = Colors.blueGrey;
            reverseController(leftTime, offDuration);
          } else {
            isOnCycle = true;
            progressBarColor = Colors.orange;
            if (currentExercise == exercises) {
              currentExercise = 0;
              currentSet++;
            }
            currentExercise++;
            leftTime = onDuration;
            reverseController(leftTime, onDuration);
          }
        }
      }
    } else {
      leftTime = Duration(seconds: leftTime.inSeconds - 1);
    }
    refreshWidget();
  }

  void configCountDown() {
    if (!isStarted) {
      if (!isCountDownOn) {
        isCountDownOn = true;
        leftTime = const Duration(seconds: 10);
        progressBarColor = Colors.orange;
      } else {
        if (isCountDownOn) {
          isCountDownOn = false;
        }
      }
    }
    refreshWidget();
  }

  void startPauseTimer() {
    if (isOnCycle) {
      reverseController(leftTime, onDuration);
    } else {
      reverseController(leftTime, onDuration);
    }
    if (!isRunning) {
      isRunning = true;
      secondsTimer =
          Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
    } else {
      secondsTimer.cancel();
      controller.stop();
      isRunning = false;
    }
  }
}

class CustomTimer {
  CustomTimer(
      {required this.timer1,
      required this.timer2,
      required this.timer3,
      required this.restBetweenTimers});

  dynamic timer1, timer2, timer3;
  int currentTimer = 1;
  List<bool> started = [false, false, false];
  late AnimationController controller;
  late Duration leftTime;
  Duration restBetweenTimers;
  bool isRunning = false, isResting = false;
  late CountdownTimer restTimer;

  void reverseController(
      Duration descendingDuration, Duration referenceDuration) {
    controller.duration = Duration(seconds: descendingDuration.inSeconds + 1);
    controller.reverse(
        from: descendingDuration.inSeconds / (referenceDuration.inSeconds));
  }

  void stopTimer() {
    switch (currentTimer) {
      case 1:
        timer1.stopTimer();
        break;
      case 2:
        timer2.stopTimer();
        break;
      case 3:
        timer3.stopTimer();
        break;
    }
    currentTimer = 1;
    started = [false, false, false];
    isRunning = false;
    isResting = false;
    controller.reset();
    controller.stop();
    timer1.refreshWidget();
  }

  void computeInternalParams() {
    timer1.computeInternalParams();
    timer2.computeInternalParams();
    timer3.computeInternalParams();
    timer1.controller = controller;
    timer2.controller = controller;
    timer3.controller = controller;
    leftTime = Duration(seconds: 10);
    restTimer = CountdownTimer(
        settings: countDownTimerSettings(duration: restBetweenTimers));
    restTimer.isStarted = true;
    restTimer.computeInternalParams();
    restTimer.controller = controller;
    restTimer.refreshWidget = timer1.refreshWidget;
    restTimer.leftTime = restTimer.settings!.duration;
  }

  void startPauseTimer() {
    if (isResting) {
      restTimer.startPauseTimer();
    } else {
      if (!isRunning) {
        isRunning = true;
        switch (currentTimer) {
          case 1:
            timer1.configCountDown();
            timer1.startPauseTimer();
            started[0] = true;
            break;
          case 2:
            timer2.configCountDown();
            timer2.startPauseTimer();
            started[1] = true;
            break;
          case 3:
            timer3.configCountDown();
            timer3.startPauseTimer();
            started[2] = true;
            break;
        }
      } else {
        isRunning = false;
        controller.stop();
        switch (currentTimer) {
          case 1:
            timer1.startPauseTimer();
            break;
          case 2:
            timer2.startPauseTimer();
            break;
          case 3:
            timer3.startPauseTimer();
            break;
        }
      }
    }
  }
}
