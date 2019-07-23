import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thirty_days_of_flutter/common/widgets/custom-cupertino-nav-bar.dart';

class Day1 extends StatelessWidget {
  static const SCREEN_TITLE = 'Day 1 - Stopwatch';
  static const SCREEN_ROUTE = 'day1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomCupertinoNavBar(
          title: SCREEN_TITLE,
        ),
        body: Center(
          child: Text(Day1.SCREEN_TITLE),
        ));
  }
}
