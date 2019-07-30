import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thirty_days_of_flutter/common/widgets/custom-cupertino-nav-bar.dart';
import 'package:thirty_days_of_flutter/days/day1/day1.dart';
import 'package:thirty_days_of_flutter/days/day2/day2.dart';
import 'package:thirty_days_of_flutter/days/day3/day3.dart';
import 'package:thirty_days_of_flutter/days/day4/day4.dart';
import 'package:thirty_days_of_flutter/days/day5/day5.dart';
import 'package:thirty_days_of_flutter/days/day6/day6.dart';
import 'package:thirty_days_of_flutter/days/day7/day7.dart';
import 'package:thirty_days_of_flutter/days/day8/day8.dart';

class MenuItemData {
  String name;
  String route;

  MenuItemData(this.name, this.route);
}

class MenuItemWidget extends StatelessWidget {
  final String label;
  final Function onPress;

  MenuItemWidget(this.label, this.onPress);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CupertinoButton(
        child: Text(label),
        onPressed: onPress,
      ),
    );
  }
}

class Menu extends StatelessWidget {
  static const SCREEN_ROUTE = '/';
  static const SCREEN_TITLE = '30 Days Of Flutter';

  final List<MenuItemData> menusItemDataArr = [
    MenuItemData(Day1.SCREEN_TITLE, Day1.SCREEN_ROUTE),
    MenuItemData(Day2.SCREEN_TITLE, Day2.SCREEN_ROUTE),
    MenuItemData(Day3.SCREEN_TITLE, Day3.SCREEN_ROUTE),
    MenuItemData(Day4.SCREEN_TITLE, Day4.SCREEN_ROUTE),
    MenuItemData(Day5.SCREEN_TITLE, Day5.SCREEN_ROUTE),
    MenuItemData(Day6.SCREEN_TITLE, Day6.SCREEN_ROUTE),
    MenuItemData(Day7.SCREEN_TITLE, Day7.SCREEN_ROUTE),
    MenuItemData(Day8.SCREEN_TITLE, Day8.SCREEN_ROUTE),
  ];

  void _onMenuItemPress(BuildContext context, MenuItemData menu) {
    Navigator.pushNamed(context, menu.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCupertinoNavBar(
        title: SCREEN_TITLE,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              child: ListView(
                children: menusItemDataArr
                    .map((menu) => MenuItemWidget(menu.name, () {
                          _onMenuItemPress(context, menu);
                        }))
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
