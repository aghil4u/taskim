import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage_MapTab extends StatefulWidget {
  _HomePage_MapTabState createState() => _HomePage_MapTabState();
}

class _HomePage_MapTabState extends State<HomePage_MapTab>
    with AutomaticKeepAliveClientMixin<HomePage_MapTab> {
  GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      options: GoogleMapOptions(
          myLocationEnabled: true,
          cameraPosition:
              CameraPosition(target: LatLng(23.4241, 53.300), zoom: 10.0),
          scrollGesturesEnabled: true,
          rotateGesturesEnabled: true),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
