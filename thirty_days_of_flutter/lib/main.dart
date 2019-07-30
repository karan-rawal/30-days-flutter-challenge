import 'package:flutter/cupertino.dart';
import 'package:thirty_days_of_flutter/days/day1/day1.dart';
import 'package:thirty_days_of_flutter/days/day2/day2.dart';
import 'package:thirty_days_of_flutter/days/day2/screens/map-screen.dart';
import 'package:thirty_days_of_flutter/days/day3/day3.dart';
import 'package:thirty_days_of_flutter/days/day4/day4.dart';
import 'package:thirty_days_of_flutter/days/day5/day5.dart';
import 'package:thirty_days_of_flutter/days/day6/day6.dart';
import 'package:thirty_days_of_flutter/days/day7/day7.dart';
import 'package:thirty_days_of_flutter/menu.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  static const String APP_TITLE = '30 Days Of Flutter';

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: Main.APP_TITLE,
      initialRoute: Menu.SCREEN_ROUTE,
      routes: {
        Menu.SCREEN_ROUTE: (context) => Menu(),
        Day1.SCREEN_ROUTE: (context) => Day1(),
        Day2.SCREEN_ROUTE: (context) => Day2(),
        MapScreen.SCREEN_ROUTE: (context) => MapScreen(),
        Day3.SCREEN_ROUTE: (context) => Day3(),
        Day4.SCREEN_ROUTE: (context) => Day4(),
        Day5.SCREEN_ROUTE: (context) => Day5(),
        Day6.SCREEN_ROUTE: (context) => Day6(),
        Day7.SCREEN_ROUTE: (context) => Day7(),
      },
    );
  }
}