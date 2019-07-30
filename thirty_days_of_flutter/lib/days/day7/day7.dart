import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thirty_days_of_flutter/common/widgets/custom-cupertino-nav-bar.dart';

class Day7 extends StatefulWidget {
  static const SCREEN_TITLE = 'Day 7 - The Clock';
  static const SCREEN_ROUTE = 'day7';

  @override
  _Day7State createState() => _Day7State();
}

const double CLOCK_RADIUS = 150;
const double CLOCK_DIAMETER = CLOCK_RADIUS * 2;

class _Day7State extends State<Day7> {
  DateTime dateTime;
  Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
      setState(() {
        dateTime = DateTime.now();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCupertinoNavBar(
        title: Day7.SCREEN_TITLE,
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
            ClockBackground(),
            ClockDial(),
            ClockHands(dateTime),
          ],
        ),
      ),
    );
  }
}

class ClockHandsPainter extends CustomPainter {
  DateTime dateTime;
  ClockHandsPainter(this.dateTime);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(CLOCK_RADIUS, CLOCK_RADIUS);

    // draw seconds hand
    double seconds = (dateTime.second + (dateTime.millisecond / 1000));
    double degrees = seconds / 60 * 360;
    canvas.save();
    canvas.rotate(degrees * pi / 180);
    Offset p1 = Offset(0, 0);
    Offset p2 = Offset(0, (-CLOCK_RADIUS) + 30);
    Paint p = Paint();
    p.color = Colors.black;
    p.strokeCap = StrokeCap.round;
    p.strokeWidth = 4;
    canvas.drawLine(p1, p2, p);
    canvas.restore();

    // draw minutes hand
    double minutes = (dateTime.minute + (seconds / 60));
    degrees = minutes / 60 * 360;
    canvas.save();
    canvas.rotate(degrees * pi / 180);
    p1 = Offset(0, 0);
    p2 = Offset(0, (-CLOCK_RADIUS) + 50);
    canvas.drawLine(p1, p2, p);
    canvas.restore();

    // draw hour hand
    double hour = (dateTime.hour + (minutes / 60));
    degrees = hour / 12 * 360;
    canvas.save();
    canvas.rotate(degrees * pi / 180);
    p1 = Offset(0, 0);
    p2 = Offset(0, (-CLOCK_RADIUS) + 80);
    canvas.drawLine(p1, p2, p);
    canvas.restore();

    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class ClockHands extends StatelessWidget {
  final DateTime dateTime;
  
  ClockHands(this.dateTime);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: ClockHandsPainter(dateTime),
      ),
    );
  }
}

class ClockBackground extends StatelessWidget {
  const ClockBackground({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(CLOCK_RADIUS)),
        elevation: 3,
        child: Container(
          width: CLOCK_DIAMETER,
          height: CLOCK_DIAMETER,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(CLOCK_RADIUS)),
          ),
        ),
      ),
    );
  }
}

class ClockDialPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double degrees = 0;
    double degreesToMove = 360 / 12;
    canvas.translate(CLOCK_RADIUS, CLOCK_RADIUS);

    while (degrees < 360) {
      canvas.save();
      canvas.rotate((degrees) * pi / 180);
      Offset p1 = Offset(0, -CLOCK_RADIUS + 10);
      Offset p2 = Offset(0, -CLOCK_RADIUS + 15);
      Paint paint = Paint();
      paint.color = Colors.black;
      paint.strokeWidth = 2;
      canvas.drawLine(p1, p2, paint);

      degrees += degreesToMove;
      canvas.restore();
    }

    degrees = 0;
    degreesToMove = 360 / 60;
    while (degrees < 360) {
      canvas.save();
      canvas.rotate((degrees) * pi / 180);
      Offset p1 = Offset(0, -CLOCK_RADIUS + 10);
      Offset p2 = Offset(0, -CLOCK_RADIUS + 12);
      Paint paint = Paint();
      paint.color = Colors.black;
      paint.strokeWidth = 2;
      canvas.drawLine(p1, p2, paint);
      print(degrees);
      canvas.restore();
      degrees += degreesToMove;
    }
  }

  @override
  bool shouldRepaint(ClockDialPainter oldDelegate) {
    return true;
  }
}

class ClockDial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: ClockDialPainter(),
      ),
    );
  }
}
