import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

class Intro {
  String title;
  String content;
  String content2;

  Intro(this.title, this.content, this.content2);
}

final List<Intro> intros = [
  Intro('Welcome', 'Sign up for free music on your phone,tablet',
      'and computer.'),
  Intro('Browse', 'Explore top tracks, new releases and the right',
      'playlist for every moment.'),
  Intro('Search', 'Looking for that special album or artist? Just',
      'search and hit play!'),
  Intro('Running', 'Music that perfectly matches', 'your tempo.'),
  Intro('Your Library', 'Save any song,album or artist to your own',
      'music collection.'),
];

class Day4 extends StatefulWidget {
  static const SCREEN_TITLE = 'Day 4 - Spotify Login Screen';
  static const SCREEN_ROUTE = 'day4';

  @override
  State<StatefulWidget> createState() {
    return _Day4State();
  }
}

class _Day4State extends State<Day4> {
  VideoPlayerController videoController;
  Future<void> videoFuture;

  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.asset('assets/moments.mp4');
    videoFuture = videoController.initialize();
    videoController.setLooping(true);
    videoController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          Stack(
            children: <Widget>[
              VideoPlayer(videoController),
              IntroSwiper(),
            ],
          ),
          SpotifyLogo(),
          Footer(),
        ],
      ),
    ));
  }
}

class IntroSwiper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(bottom: 100),
      child: Swiper(
        autoplayDelay: 4000,
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            size: 6.0,
            color: Colors.white10,
            activeColor: Colors.white,
            activeSize: 6.0,
          ),
        ),
        itemCount: intros.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          Intro intro = intros[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  intro.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Text(
                  intro.content,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  intro.content2,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -2,
      left: 0.0,
      right: 0.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: FlatButton(
              color: Colors.black,
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                'LOGIN',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: FlatButton(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              color: Colors.green,
              child: Text('SIGN UP', style: TextStyle(color: Colors.white)),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class SpotifyLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Positioned(
      top: 80,
      left: 0.0,
      right: 0.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            FontAwesomeIcons.spotify,
            color: Colors.white,
            size: 60.0,
          ),
          SizedBox(
            width: 10,
          ),
          Text("Spotify",
              style: TextStyle(
                  fontSize: 35.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    ));
  }
}
