import 'package:flutter/cupertino.dart';

class CustomCupertinoNavBar extends CupertinoNavigationBar {
  final String title;

  CustomCupertinoNavBar({@required this.title})
      : super(
          middle: Container(
            alignment: Alignment.center,
            width: 260,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(child: Text(title)),
          ),
        );
}
