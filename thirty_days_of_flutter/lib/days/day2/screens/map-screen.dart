import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:thirty_days_of_flutter/common/widgets/custom-cupertino-nav-bar.dart';

class MapScreen extends StatefulWidget {
  static const SCREEN_TITLE = 'Find my location';
  static const SCREEN_ROUTE = 'day2/find-my-location';

  @override
  State<MapScreen> createState() {
    return _MapScreenState();
  }
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition initialPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    LocationData locationData = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: CustomCupertinoNavBar(
        title: MapScreen.SCREEN_TITLE,
      ),
      body: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          Timer(Duration(seconds: 3), () {
            controller
                .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
              target: LatLng(locationData.latitude, locationData.longitude),
              zoom: 18,
            )));
          });
        },
      ),
    );
  }
}
