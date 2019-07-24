import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thirty_days_of_flutter/common/widgets/custom-cupertino-nav-bar.dart';
import 'package:thirty_days_of_flutter/days/day2/screens/map-screen.dart';

class Day2 extends StatelessWidget {
  static const SCREEN_TITLE = 'Find my location';
  static const SCREEN_ROUTE = 'day2';

  void _onFindLocationPress(context) {
    Navigator.pushNamed(context, MapScreen.SCREEN_ROUTE);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCupertinoNavBar(
        title: SCREEN_TITLE,
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () { _onFindLocationPress(context); },
          child: Text(SCREEN_TITLE),
        ),
      ),
    );
  }
}