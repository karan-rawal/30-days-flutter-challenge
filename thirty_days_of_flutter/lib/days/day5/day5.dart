import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:thirty_days_of_flutter/common/widgets/custom-cupertino-nav-bar.dart';
import 'package:http/http.dart' as http;

class Day5 extends StatefulWidget {
  static const SCREEN_TITLE = 'Day 5 - Sticky Header';
  static const SCREEN_ROUTE = 'day5';

  @override
  State<StatefulWidget> createState() {
    return Day5State();
  }
}

class Day5State extends State<Day5> {
  String picsumApi = 'https://picsum.photos/list';
  Future photosFuture;
  List<PicsumImage> photosList = [];

  fetchPhotos() {
    return http.get(picsumApi);
  }

  @override
  void initState() {
    photosFuture = fetchPhotos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomCupertinoNavBar(
        title: Day5.SCREEN_TITLE,
      ),
      body: FutureBuilder(
        future: photosFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List photos = jsonDecode(snapshot.data.body);
            List<PicsumImage> photosList = photos.map((photo) {
              return PicsumImage.fromJson(photo);
            }).toList();

            return ListView(
              children: photosList.map((photo) {
                return StickyHeader(
                  header: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    alignment: Alignment.centerLeft,
                    color: Colors.white,
                    child: Text(
                      '${photo.author}',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                  content: Container(
                    height: 250,
                    child: Image.network(
                      'https://picsum.photos/id/${photo.id}/400/300',
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              }).toList(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Failed to load data."),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(height: 10,),
                  Text('Fetching images')
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class PicsumImage {
  String format;
  int width;
  int height;
  String filename;
  int id;
  String author;
  final String authorUrl;
  String postUrl;

  PicsumImage({
    this.format,
    this.width,
    this.height,
    this.filename,
    this.id,
    @required this.author,
    this.authorUrl,
    @required this.postUrl,
  });

  factory PicsumImage.fromJson(dynamic photo) {
    return PicsumImage(
      format: photo['format'],
      width: photo['width'],
      height: photo['height'],
      filename: photo['filename'],
      id: photo['id'],
      author: photo['author'],
      authorUrl: photo['author_url'],
      postUrl: photo['post_url'],
    );
  }
}

class StickyHeader extends MultiChildRenderObjectWidget {
  StickyHeader({
    content,
    header,
  }) : super(children: [content, header]);

  @override
  RenderObject createRenderObject(BuildContext context) {
    var scrollableState = Scrollable.of(context);
    return StickyHeaderRenderBox(
      scrollableState: scrollableState,
    );
  }
}

class StickyHeaderRenderBox extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, MultiChildLayoutParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, MultiChildLayoutParentData> {
  ScrollableState scrollableState;

  StickyHeaderRenderBox({@required this.scrollableState});

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    scrollableState.position.addListener(markNeedsLayout);
  }

  @override
  void detach() {
    scrollableState.position.removeListener(markNeedsLayout);
    super.detach();
  }

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! MultiChildLayoutParentData) {
      child.parentData = MultiChildLayoutParentData();
    }
    super.setupParentData(child);
  }

  @override
  void performLayout() {
    RenderBox header = lastChild;
    RenderBox content = firstChild;

    BoxConstraints boxConstraints = BoxConstraints(
      maxHeight: constraints.maxHeight,
      minHeight: constraints.minHeight,
      maxWidth: constraints.maxWidth,
      minWidth: constraints.minWidth,
    );

    header.layout(boxConstraints, parentUsesSize: true);
    content.layout(boxConstraints, parentUsesSize: true);

    final width = header.size.width;
    final height = content.size.height;

    final maxHeaderOffset = height - header.size.height;

    final scrollBox = scrollableState.context.findRenderObject();
    final scrollY = localToGlobal(Offset.zero, ancestor: scrollBox).dy;

    final headerParentData = header.parentData as MultiChildLayoutParentData;
    headerParentData.offset =
        Offset(0.0, max(0.0, min(-scrollY, maxHeaderOffset)));

    size = Size(width, height);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }
}
