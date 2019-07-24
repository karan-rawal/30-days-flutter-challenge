import 'package:flutter/cupertino.dart';
import 'package:thirty_days_of_flutter/days/day1/day1.dart';
import 'package:thirty_days_of_flutter/days/day2/day2.dart';
import 'package:thirty_days_of_flutter/days/day2/screens/map-screen.dart';
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
        MapScreen.SCREEN_ROUTE: (context) => MapScreen()
      },
    );
  }
}