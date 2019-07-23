import 'package:flutter/cupertino.dart';
import 'package:thirty_days_of_flutter/common/widgets/custom-cupertino-nav-bar.dart';

class Day1 extends StatelessWidget {
  static const SCREEN_TITLE = 'Day 1 - Stopwatch';
  static const SCREEN_ROUTE = 'day1';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CustomCupertinoNavBar(
          title: SCREEN_TITLE,
        ),
        child: Center(
          child: Text(Day1.SCREEN_TITLE),
        ));
  }
}
