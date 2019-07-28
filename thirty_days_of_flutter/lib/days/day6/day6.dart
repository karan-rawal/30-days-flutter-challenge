import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Day6 extends StatefulWidget {
  static const SCREEN_TITLE = 'Day 6 - Twitter User Page';
  static const SCREEN_ROUTE = 'day6';

  @override
  _Day6State createState() => _Day6State();
}

class _Day6State extends State<Day6> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Day 6"),),
    );
  }
}