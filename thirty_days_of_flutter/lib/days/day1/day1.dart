import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thirty_days_of_flutter/common/widgets/custom-cupertino-nav-bar.dart';

formatDuration(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  String millis = duration.inMilliseconds.remainder(1000).toString();
  millis = millis.padLeft(4, '0');
  millis = millis.substring(0, 3);
  String twoDigitMillis = twoDigits(int.parse(millis));

  return "${twoDigitMinutes}:$twoDigitSeconds:$twoDigitMillis";
}

class Day1 extends StatefulWidget {
  static const SCREEN_TITLE = 'Day 1 - Stopwatch';
  static const SCREEN_ROUTE = 'day1';

  @override
  State<Day1> createState() {
    return Day1State();
  }
}

class Day1State extends State<Day1> {
  DateTime startTime = DateTime.now();
  DateTime currentTime = DateTime.now();
  DateTime resetTime = DateTime.now();
  List<String> records = [];
  Timer timer;
  bool hasStarted = false;

  void timerTick(timer) {
    setState(() {
      currentTime = currentTime.add(new Duration(milliseconds: 1));
      resetTime = resetTime.add(new Duration(milliseconds: 1));
    });
  }

  void record() {
    setState(() {
      records.add(formatDuration(resetTime.difference(startTime)));
      resetTime = startTime;
    });
  }

  void start() {
    setState(() {
      startTime = DateTime.now();
      currentTime = DateTime.now();
      resetTime = DateTime.now();
      hasStarted = true;
      records.clear();
    });
    if (timer == null) {
      timer = new Timer.periodic(Duration(milliseconds: 1), timerTick);
    } else {
      timer.cancel();
      timer = new Timer.periodic(Duration(milliseconds: 1), timerTick);
    }
  }

  void stop() {
    if (timer != null) {
      timer.cancel();
    }
    setState(() {
      hasStarted = false;
      records.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomCupertinoNavBar(
          title: Day1.SCREEN_TITLE,
        ),
        body: Column(
          children: <Widget>[
            WatchTimers(currentTime, startTime, resetTime),
            WatchControls(start, stop, record, hasStarted),
            WatchRecords(records),
          ],
        ));
  }
}

class WatchTimers extends StatelessWidget {
  final DateTime currentTime;
  final DateTime startTime;
  final DateTime resetTime;

  WatchTimers(this.currentTime, this.startTime, this.resetTime);

  @override
  Widget build(BuildContext context) {
    var resetTimeDiff = resetTime.difference(startTime);
    var currentTimeDiff = currentTime.difference(startTime);

    var resetTimeString = formatDuration(resetTimeDiff);
    var currentTimeString = formatDuration(currentTimeDiff);

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[Text(resetTimeString)],
        ),
        Row(
          children: <Widget>[Text(currentTimeString)],
        ),
      ],
    );
  }
}

class WatchControls extends StatelessWidget {
  final Function onStartPress;
  final Function onStopPress;
  final Function onRecordPress;
  final bool hasStarted;

  WatchControls(
      this.onStartPress, this.onStopPress, this.onRecordPress, this.hasStarted);

  @override
  Widget build(BuildContext context) {
    String startButtonText = hasStarted ? 'Stop' : 'Start';
    Function onStartCallback =
        hasStarted ? this.onStopPress : this.onStartPress;
    Function recordPress = hasStarted ? onRecordPress : null;

    return Row(
      children: <Widget>[
        RaisedButton(
          child: Text('Record'),
          onPressed: recordPress,
        ),
        RaisedButton(
          child: Text(startButtonText),
          onPressed: onStartCallback,
        ),
      ],
    );
  }
}

class WatchRecords extends StatelessWidget {
  final List<String> records;

  WatchRecords(this.records);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: records
            .asMap()
            .map((index, record) => MapEntry(
                index,
                Row(
                  children: <Widget>[
                    Text('Lap ${index}'),
                    Text(record),
                  ],
                )))
            .values
            .toList(),
      ),
    );
  }
}
