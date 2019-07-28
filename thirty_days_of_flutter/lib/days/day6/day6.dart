import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Day6 extends StatefulWidget {
  static const SCREEN_TITLE = 'Day 6 - Kind of Twitter';
  static const SCREEN_ROUTE = 'day6';

  @override
  _Day6State createState() => _Day6State();
}

class _Day6State extends State<Day6> {
  double scrollY = 0;
  ScrollController scrollController;
  double headerHeight = 60;
  double coverHeight = 200;
  double headerTextAnimDuration = 50;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      scrollY = scrollController.offset;

      setState(() {});
    });
    super.initState();
  }

  getHeaderVisibility(double scrollY) {
    if (scrollY > 500) {
      return 255;
    }
    double triggerOffset = coverHeight - headerHeight;
    if (scrollY > triggerOffset) {
      return 255;
    } else {
      return 0;
    }
  }

  getHeaderTextColor(double scrollY) {
    if (scrollY > 500) {
      return Colors.white.withAlpha(255);
    }
    double startFrom = coverHeight - headerHeight;
    double afterApplyingStart = scrollY - startFrom;
    if (getHeaderVisibility(scrollY) != 0) {
      return Colors.white.withAlpha(afterApplyingStart.clamp(0, 255).round());
    }
    return Colors.white.withAlpha(0);
  }

  getIconScale(double scrollY) {
    if (scrollY > 500) {
      return 1.5;
    }
    if (scrollY <= 0) {
      return 1.5;
    }
    var newScale = 1.5 - (scrollY / 200).clamp(0, 1);
    return newScale.clamp(1.0, 1.5);
  }

  @override
  Widget build(BuildContext context) {
    var headerAlpha = getHeaderVisibility(scrollY);

    Widget header = Positioned(
      child: Container(
        alignment: Alignment.center,
        height: headerHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blueAccent.withAlpha(headerAlpha),
        ),
        child: Text(
          "Github",
          style: TextStyle(color: getHeaderTextColor(scrollY), fontSize: 20),
        ),
      ),
    );

    ListView content = ListView(
      controller: scrollController,
      children: <Widget>[
        Container(
          height: coverHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/banner.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Transform(
                    alignment: FractionalOffset.bottomLeft,
                    transform: Matrix4.identity()..scale(getIconScale(scrollY)),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(3.0),
                          ),
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/github.png')),
                          border: Border.all(color: Colors.white, width: 5.0)),
                      width: 80,
                      height: 80,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.settings,
                    color: Colors.blueGrey,
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: Colors.blueGrey,
                          width: 2,
                        )),
                    child: Icon(Icons.people, color: Colors.blueGrey),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                          color: Colors.blueGrey,
                          width: 2,
                        )),
                    child: Text("Edit Profile"),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  'Github',
                  style: TextStyle(
                      color: Color(0xFF292F33),
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: Text(
                  '@github',
                  style: TextStyle(color: Color(0xFF66757F)),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(children: <Widget>[
                  Container(
                      width: 110.0,
                      child: Row(children: <Widget>[
                        Text('183',
                            style: TextStyle(
                                color: Color(0xFF292F33),
                                fontWeight: FontWeight.w500)),
                        Text(' Followers',
                            style: TextStyle(color: Color(0xFF95A4AE))),
                      ])),
                  Container(
                    width: 110.0,
                    child: Row(children: <Widget>[
                      Text(
                        '830k',
                        style: TextStyle(
                            color: Color(0xFF292F33),
                            fontWeight: FontWeight.w500),
                      ),
                      Text(' Following',
                          style: TextStyle(color: Color(0xFF95A4AE))),
                    ]),
                  ),
                ]),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                child: CupertinoSegmentedControl(
                  key: Key('segmented'),
                  onValueChanged: (a) {},
                  children: {
                    '0': Text('Tweets'),
                    '1': Text('Replies'),
                    '2': Text('Media')
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 80,
          decoration: BoxDecoration(
              color: Color(0xffdddddd),
              border: Border(
                  top: BorderSide(color: Color(0xffcccccd), width: 2.0))),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          alignment: Alignment.bottomLeft,
          child: Text(
            "Suggestions",
            style: TextStyle(color: Colors.blueGrey, fontSize: 20),
          ),
        ),
        ...[
          SuggestionWidget("Github", '@github',
              'https://s3-ap-south-1.amazonaws.com/av-blog-media/wp-content/uploads/2018/02/github1.png'),
          SuggestionWidget("Microsoft", '@microsoft',
              'https://c.s-microsoft.com/en-us/CMSImages/page-sharing-thumbnail.jpg?version=ad58d6d8-0f5a-b7a8-ea50-939410935c7c'),
          SuggestionWidget("Google", '@google',
              'https://blog.hubspot.com/hs-fs/hubfs/image8-2.jpg?width=600&name=image8-2.jpg'),
          SuggestionWidget("Facebook", '@facebook',
              'https://image.flaticon.com/icons/png/512/124/124010.png'),
          SuggestionWidget("Twitter", '@twitter',
              'https://seeklogo.com/images/T/twitter-2012-negative-logo-5C6C1F1521-seeklogo.com.png'),
          SuggestionWidget("Instagram", '@instagram',
              'https://instagram-brand.com/wp-content/uploads/2016/11/Instagram_AppIcon_Aug2017.png?w=300'),
          SuggestionWidget("Github", '@github',
              'https://s3-ap-south-1.amazonaws.com/av-blog-media/wp-content/uploads/2018/02/github1.png'),
          SuggestionWidget("Microsoft", '@microsoft',
              'https://c.s-microsoft.com/en-us/CMSImages/page-sharing-thumbnail.jpg?version=ad58d6d8-0f5a-b7a8-ea50-939410935c7c'),
          SuggestionWidget("Google", '@google',
              'https://blog.hubspot.com/hs-fs/hubfs/image8-2.jpg?width=600&name=image8-2.jpg'),
          SuggestionWidget("Facebook", '@facebook',
              'https://image.flaticon.com/icons/png/512/124/124010.png'),
          SuggestionWidget("Twitter", '@twitter',
              'https://seeklogo.com/images/T/twitter-2012-negative-logo-5C6C1F1521-seeklogo.com.png'),
          SuggestionWidget("Instagram", '@instagram',
              'https://instagram-brand.com/wp-content/uploads/2016/11/Instagram_AppIcon_Aug2017.png?w=300'),
          SuggestionWidget("Github", '@github',
              'https://s3-ap-south-1.amazonaws.com/av-blog-media/wp-content/uploads/2018/02/github1.png'),
          SuggestionWidget("Microsoft", '@microsoft',
              'https://c.s-microsoft.com/en-us/CMSImages/page-sharing-thumbnail.jpg?version=ad58d6d8-0f5a-b7a8-ea50-939410935c7c'),
          SuggestionWidget("Google", '@google',
              'https://blog.hubspot.com/hs-fs/hubfs/image8-2.jpg?width=600&name=image8-2.jpg'),
          SuggestionWidget("Facebook", '@facebook',
              'https://image.flaticon.com/icons/png/512/124/124010.png'),
          SuggestionWidget("Twitter", '@twitter',
              'https://seeklogo.com/images/T/twitter-2012-negative-logo-5C6C1F1521-seeklogo.com.png'),
          SuggestionWidget("Instagram", '@instagram',
              'https://instagram-brand.com/wp-content/uploads/2016/11/Instagram_AppIcon_Aug2017.png?w=300'),
          SuggestionWidget("Github", '@github',
              'https://s3-ap-south-1.amazonaws.com/av-blog-media/wp-content/uploads/2018/02/github1.png'),
          SuggestionWidget("Microsoft", '@microsoft',
              'https://c.s-microsoft.com/en-us/CMSImages/page-sharing-thumbnail.jpg?version=ad58d6d8-0f5a-b7a8-ea50-939410935c7c'),
          SuggestionWidget("Google", '@google',
              'https://blog.hubspot.com/hs-fs/hubfs/image8-2.jpg?width=600&name=image8-2.jpg'),
          SuggestionWidget("Facebook", '@facebook',
              'https://image.flaticon.com/icons/png/512/124/124010.png'),
          SuggestionWidget("Twitter", '@twitter',
              'https://seeklogo.com/images/T/twitter-2012-negative-logo-5C6C1F1521-seeklogo.com.png'),
          SuggestionWidget("Instagram", '@instagram',
              'https://instagram-brand.com/wp-content/uploads/2016/11/Instagram_AppIcon_Aug2017.png?w=300'),
          SuggestionWidget("Github", '@github',
              'https://s3-ap-south-1.amazonaws.com/av-blog-media/wp-content/uploads/2018/02/github1.png'),
          SuggestionWidget("Microsoft", '@microsoft',
              'https://c.s-microsoft.com/en-us/CMSImages/page-sharing-thumbnail.jpg?version=ad58d6d8-0f5a-b7a8-ea50-939410935c7c'),
          SuggestionWidget("Google", '@google',
              'https://blog.hubspot.com/hs-fs/hubfs/image8-2.jpg?width=600&name=image8-2.jpg'),
          SuggestionWidget("Facebook", '@facebook',
              'https://image.flaticon.com/icons/png/512/124/124010.png'),
          SuggestionWidget("Twitter", '@twitter',
              'https://seeklogo.com/images/T/twitter-2012-negative-logo-5C6C1F1521-seeklogo.com.png'),
          SuggestionWidget("Instagram", '@instagram',
              'https://instagram-brand.com/wp-content/uploads/2016/11/Instagram_AppIcon_Aug2017.png?w=300'),
          SuggestionWidget("Github", '@github',
              'https://s3-ap-south-1.amazonaws.com/av-blog-media/wp-content/uploads/2018/02/github1.png'),
          SuggestionWidget("Microsoft", '@microsoft',
              'https://c.s-microsoft.com/en-us/CMSImages/page-sharing-thumbnail.jpg?version=ad58d6d8-0f5a-b7a8-ea50-939410935c7c'),
          SuggestionWidget("Google", '@google',
              'https://blog.hubspot.com/hs-fs/hubfs/image8-2.jpg?width=600&name=image8-2.jpg'),
          SuggestionWidget("Facebook", '@facebook',
              'https://image.flaticon.com/icons/png/512/124/124010.png'),
          SuggestionWidget("Twitter", '@twitter',
              'https://seeklogo.com/images/T/twitter-2012-negative-logo-5C6C1F1521-seeklogo.com.png'),
          SuggestionWidget("Instagram", '@instagram',
              'https://instagram-brand.com/wp-content/uploads/2016/11/Instagram_AppIcon_Aug2017.png?w=300'),
          SuggestionWidget("Github", '@github',
              'https://s3-ap-south-1.amazonaws.com/av-blog-media/wp-content/uploads/2018/02/github1.png'),
          SuggestionWidget("Microsoft", '@microsoft',
              'https://c.s-microsoft.com/en-us/CMSImages/page-sharing-thumbnail.jpg?version=ad58d6d8-0f5a-b7a8-ea50-939410935c7c'),
          SuggestionWidget("Google", '@google',
              'https://blog.hubspot.com/hs-fs/hubfs/image8-2.jpg?width=600&name=image8-2.jpg'),
          SuggestionWidget("Facebook", '@facebook',
              'https://image.flaticon.com/icons/png/512/124/124010.png'),
          SuggestionWidget("Twitter", '@twitter',
              'https://seeklogo.com/images/T/twitter-2012-negative-logo-5C6C1F1521-seeklogo.com.png'),
          SuggestionWidget("Instagram", '@instagram',
              'https://instagram-brand.com/wp-content/uploads/2016/11/Instagram_AppIcon_Aug2017.png?w=300'),
          SuggestionWidget("Github", '@github',
              'https://s3-ap-south-1.amazonaws.com/av-blog-media/wp-content/uploads/2018/02/github1.png'),
          SuggestionWidget("Microsoft", '@microsoft',
              'https://c.s-microsoft.com/en-us/CMSImages/page-sharing-thumbnail.jpg?version=ad58d6d8-0f5a-b7a8-ea50-939410935c7c'),
          SuggestionWidget("Google", '@google',
              'https://blog.hubspot.com/hs-fs/hubfs/image8-2.jpg?width=600&name=image8-2.jpg'),
          SuggestionWidget("Facebook", '@facebook',
              'https://image.flaticon.com/icons/png/512/124/124010.png'),
          SuggestionWidget("Twitter", '@twitter',
              'https://seeklogo.com/images/T/twitter-2012-negative-logo-5C6C1F1521-seeklogo.com.png'),
          SuggestionWidget("Instagram", '@instagram',
              'https://instagram-brand.com/wp-content/uploads/2016/11/Instagram_AppIcon_Aug2017.png?w=300'),
          SuggestionWidget("Github", '@github',
              'https://s3-ap-south-1.amazonaws.com/av-blog-media/wp-content/uploads/2018/02/github1.png'),
          SuggestionWidget("Microsoft", '@microsoft',
              'https://c.s-microsoft.com/en-us/CMSImages/page-sharing-thumbnail.jpg?version=ad58d6d8-0f5a-b7a8-ea50-939410935c7c'),
          SuggestionWidget("Google", '@google',
              'https://blog.hubspot.com/hs-fs/hubfs/image8-2.jpg?width=600&name=image8-2.jpg'),
          SuggestionWidget("Facebook", '@facebook',
              'https://image.flaticon.com/icons/png/512/124/124010.png'),
          SuggestionWidget("Twitter", '@twitter',
              'https://seeklogo.com/images/T/twitter-2012-negative-logo-5C6C1F1521-seeklogo.com.png'),
          SuggestionWidget("Instagram", '@instagram',
              'https://instagram-brand.com/wp-content/uploads/2016/11/Instagram_AppIcon_Aug2017.png?w=300'),
          SuggestionWidget("Github", '@github',
              'https://s3-ap-south-1.amazonaws.com/av-blog-media/wp-content/uploads/2018/02/github1.png'),
          SuggestionWidget("Microsoft", '@microsoft',
              'https://c.s-microsoft.com/en-us/CMSImages/page-sharing-thumbnail.jpg?version=ad58d6d8-0f5a-b7a8-ea50-939410935c7c'),
          SuggestionWidget("Google", '@google',
              'https://blog.hubspot.com/hs-fs/hubfs/image8-2.jpg?width=600&name=image8-2.jpg'),
          SuggestionWidget("Facebook", '@facebook',
              'https://image.flaticon.com/icons/png/512/124/124010.png'),
          SuggestionWidget("Twitter", '@twitter',
              'https://seeklogo.com/images/T/twitter-2012-negative-logo-5C6C1F1521-seeklogo.com.png'),
          SuggestionWidget("Instagram", '@instagram',
              'https://instagram-brand.com/wp-content/uploads/2016/11/Instagram_AppIcon_Aug2017.png?w=300'),
        ]
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            content,
            header,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.message),
      ),
    );
  }
}

class SuggestionWidget extends StatelessWidget {
  String title;
  String handle;
  String imgUrl;
  SuggestionWidget(
    this.title,
    this.handle,
    this.imgUrl,
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(10),
      child: (Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Image.network(imgUrl),
          ),
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  child: Text(
                    handle,
                    style: TextStyle(fontSize: 16, color: Colors.blueGrey),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                  color: Colors.blue,
                  width: 2,
                )),
            child: Icon(Icons.group_add, color: Colors.blue),
          ),
        ],
      )),
    );
  }
}
