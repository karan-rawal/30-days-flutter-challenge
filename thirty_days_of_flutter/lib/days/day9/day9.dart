import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thirty_days_of_flutter/common/widgets/custom-cupertino-nav-bar.dart';

class Day9 extends StatefulWidget {
  static const SCREEN_TITLE = 'Day 9 - Calling Native Code';
  static const SCREEN_ROUTE = 'day9';

  @override
  _Day9State createState() => _Day9State();
}

class _Day9State extends State<Day9> {
  String message;

  _onMessageChange(newMessage) {
    setState(() {
      message = newMessage;
    });
  }

  Future<void> showMessage(String message) async {
    try {
      const platform = const MethodChannel('com.karanrawal.thirty_days_of_flutter/toast');
      final bool result = await platform.invokeMethod('showToast', {
        'message': message,
      });
      print(result);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCupertinoNavBar(
        title: Day9.SCREEN_TITLE,
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            onChanged: _onMessageChange,
            decoration: InputDecoration(
              hintText: 'Enter a message...'
            ),
          ),
          RaisedButton(
            child: Text("Show Toast"),
            onPressed: () {
              showMessage(message);
            },
          )
        ],
      )),
    );
  }
}
