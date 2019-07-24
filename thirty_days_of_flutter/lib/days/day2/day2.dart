import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thirty_days_of_flutter/common/widgets/custom-cupertino-nav-bar.dart';
import 'package:thirty_days_of_flutter/days/day2/screens/map-screen.dart';

class Day2 extends StatefulWidget {
  static const SCREEN_TITLE = 'Day 2 - Find my location';
  static const SCREEN_ROUTE = 'day2';

  @override
  State<Day2> createState() {
    return _Day2State();
  }
}

class _Day2State extends State<Day2> {
  bool isBusy = false;

  void _onFindLocationPress(context) async {
    Map<PermissionGroup, PermissionStatus> permission =
        await PermissionHandler()
            .requestPermissions([PermissionGroup.location]);

    if (permission[PermissionGroup.location] != PermissionStatus.granted) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Please grant location permission"),
      ));
    } else {
      setState(() {
        isBusy = true;
      });
      Location location = Location();
      LocationData locationData = await location.getLocation();
      Navigator.pushNamed(context, MapScreen.SCREEN_ROUTE,
              arguments: locationData)
          .then((obj) {
        setState(() {
          isBusy = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCupertinoNavBar(
        title: Day2.SCREEN_TITLE,
      ),
      body: Builder(
        builder: (context) => Center(
          child: isBusy
              ? CircularProgressIndicator()
              : RaisedButton(
                  onPressed: () {
                    _onFindLocationPress(context);
                  },
                  child: Text(Day2.SCREEN_TITLE),
                ),
        ),
      ),
    );
  }
}
