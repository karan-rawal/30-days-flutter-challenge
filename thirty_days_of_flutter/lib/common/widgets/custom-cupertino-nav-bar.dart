import 'package:flutter/cupertino.dart';

class CustomCupertinoNavBar extends CupertinoNavigationBar {
  final title;

  CustomCupertinoNavBar({@required this.title})
      : super(
          middle: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(child: Text(title)),
          ),
        );
}
