import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:thirty_days_of_flutter/common/widgets/custom-cupertino-nav-bar.dart';

class CirclePainter extends CustomPainter {
  final double scale;

  CirclePainter(this.scale);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.redAccent;

    final centerOffset = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(centerOffset, size.width / 2 * scale, paint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return !(oldDelegate.scale == scale);
  }
}

class SquarePainter extends CustomPainter {
  final double scale;

  SquarePainter(this.scale);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.greenAccent;

    final centerOffset = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCenter(
        center: centerOffset,
        width: size.width * scale,
        height: size.height * scale);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(SquarePainter oldDelegate) {
    return !(oldDelegate.scale == scale);
  }
}

class PiePainter extends CustomPainter {
  final double degrees;

  PiePainter(this.degrees);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.blueAccent;

    final sweepAngle = degrees * (math.pi / 180);

    final centerOffset = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCenter(
        center: centerOffset, width: size.width, height: size.height);

    canvas.drawArc(rect, 0, sweepAngle, true, paint);
  }

  @override
  bool shouldRepaint(PiePainter oldDelegate) {
    return !(oldDelegate.degrees == degrees);
  }
}

class Day3 extends StatefulWidget {
  static const SCREEN_TITLE = 'Day 3 - Playing with canvas';
  static const SCREEN_ROUTE = 'day3';

  @override
  State<Day3> createState() {
    return _Day3State();
  }
}

class _Day3State extends State<Day3> {
  double sliderValue = 0.5;

  _onSliderChange(double value) {
    setState(() {
      sliderValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCupertinoNavBar(
        title: Day3.SCREEN_TITLE,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("${(sliderValue * 100).round()} radius"),
          SizedBox(
            height: 20,
          ),
          CustomPaint(
            painter: CirclePainter(sliderValue),
            child: Container(
              width: 100,
              height: 100,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text("${sliderValue.toStringAsFixed(2)} scale"),
          SizedBox(
            height: 20,
          ),
          CustomPaint(
            painter: SquarePainter(sliderValue),
            child: Container(
              width: 100,
              height: 100,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text("${(sliderValue * 360).round()} degrees"),
          SizedBox(
            height: 20,
          ),
          CustomPaint(
            painter: PiePainter(sliderValue * 360),
            child: Container(
              width: 100,
              height: 100,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Slider(
            onChanged: _onSliderChange,
            value: sliderValue,
          )
        ],
      )),
    );
  }
}
