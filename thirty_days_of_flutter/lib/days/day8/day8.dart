import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thirty_days_of_flutter/days/day6/day6.dart';

class Company {
  String name;
  String url;

  Company(this.name, this.url);
}

List<Company> socialApps = [
  Company('Github',
      'https://s3-ap-south-1.amazonaws.com/av-blog-media/wp-content/uploads/2018/02/github1.png'),
  Company('Microsoft',
      'https://c.s-microsoft.com/en-us/CMSImages/page-sharing-thumbnail.jpg?version=ad58d6d8-0f5a-b7a8-ea50-939410935c7c'),
  Company('Google',
      'https://blog.hubspot.com/hs-fs/hubfs/image8-2.jpg?width=600&name=image8-2.jpg'),
  Company(
      'Facebook', 'https://image.flaticon.com/icons/png/512/124/124010.png'),
  Company('Twitter',
      'https://seeklogo.com/images/T/twitter-2012-negative-logo-5C6C1F1521-seeklogo.com.png'),
];

class Day8 extends StatelessWidget {
  static const SCREEN_TITLE = 'Day 8 - Social App List';
  static const SCREEN_ROUTE = 'day8';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: socialApps.map((socialApp) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, Day6.SCREEN_ROUTE, arguments: {
              'url': socialApp.url,
              'name': socialApp.name,
            });
          },
          child: Container(
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  width: 50,
                  height: 50,
                  child: Hero(
                    child: Image.network(socialApp.url),
                    tag: socialApp.url,
                  ),
                ),
                Expanded(
                  child: Hero(
                    tag: socialApp.name,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: 50,
                      height: 50,
                      child: Text(socialApp.name),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }).toList(),
    ));
  }
}
