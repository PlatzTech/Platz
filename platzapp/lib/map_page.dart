import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatefulWidget {
  @override
  State createState() {
    return MapPageState();
  }
}

class MapPageState extends State {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition position = CameraPosition(target: LatLng(0, 0));
  final Set<Marker> _markers = {};
  @override
  void initState() {
    super.initState();
    getInitialCameraPosition();
    _onAddMarkerButtonPressed();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: new Scaffold(
          body: GoogleMap(
        initialCameraPosition: position,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
      )),
    );
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      // for (int i = 0; i < 5;i++)
      // {

      // }
      _markers.add(Marker(
// This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId("1"),
        position: LatLng(11.6248466541708, 79.4821642711759),
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      _markers.add(Marker(
// This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId("2"),
        position: LatLng(11.6176441157449, 79.4811829179526),
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      _markers.add(Marker(
// This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId("3"),
        position: LatLng(11.6201761254443, 79.4758637621999),
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      _markers.add(Marker(
// This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId("4"),
        position: LatLng(11.6265132737494, 79.4762865453959),
        infoWindow: InfoWindow(
          title: 'Really cool place',
          snippet: '5 Star Rating',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
    });
  }

  void getInitialCameraPosition() async {
    var currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    position = CameraPosition(
        target: LatLng(currentPosition.latitude, currentPosition.longitude),
        zoom: 10);
  }
}
