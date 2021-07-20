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
  CameraPosition position = CameraPosition(target: LatLng(0, 0));
  late GoogleMapController _controller;
  Marker centerPin = Marker(
      draggable: true,
      markerId: MarkerId('sourcePin'),
      position: LatLng(0, 0), // updated position
      icon: BitmapDescriptor.defaultMarker);
  LatLng latlong = LatLng(0, 0);
  Position currentPosition = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 10,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0);
  final List<Marker> _markers = [];
  final Set<Marker> filteredMarkers = {};
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
          _controller = (controller);
          _controller.animateCamera(CameraUpdate.newCameraPosition(position));
        },
        markers: filteredMarkers,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        // onCameraMove: (position) {
        //   print(position);
        //   setState(() {
        //     centerPin = Marker(
        //         draggable: true,
        //         markerId: MarkerId('sourcePin'),
        //         position: LatLng(position.target.latitude,
        //             position.target.longitude), // updated position
        //         icon: BitmapDescriptor.defaultMarker);
        //   });
        // },

        onCameraMove: ((_position) => _updatePosition(_position)),
        onCameraIdle: () {
          setState(() {
            AddMarkers();
          });
        },
      )),
    );
  }

  void _updatePosition(CameraPosition _position) {
    Position newMarkerPosition = Position(
        latitude: _position.target.latitude,
        longitude: _position.target.longitude,
        accuracy: 10,
        speedAccuracy: 10,
        speed: 10,
        timestamp: DateTime.now(),
        heading: 10,
        altitude: 10);
    Marker marker = centerPin;

    setState(() {
      // centerPin = marker.copyWith(
      //     positionParam:
      //         LatLng(newMarkerPosition.latitude, newMarkerPosition.longitude));
      centerPin = Marker(
          draggable: true,
          markerId: MarkerId('sourcePin'),
          position: LatLng(newMarkerPosition.latitude,
              newMarkerPosition.longitude), // updated position
          icon: BitmapDescriptor.defaultMarker);
      filteredMarkers
          .removeWhere((element) => element.markerId.value == 'sourcePin');
      filteredMarkers.add(centerPin);
    });
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

  void AddMarkers() {
    for (int i = 0; i < _markers.length; i++) {
      var distance = Geolocator.distanceBetween(
          centerPin.position.latitude,
          centerPin.position.longitude,
          _markers[i].position.latitude,
          _markers[i].position.longitude);
      var dividedDistance = distance / 1000;
      if (distance < 500) {
        setState(() {
          filteredMarkers
              .removeWhere((element) => element.markerId.value != 'sourcePin');
          filteredMarkers.add(_markers[i]);
        });
      }
    }
  }

  void getInitialCameraPosition() async {
    currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    latlong = LatLng(currentPosition.latitude, currentPosition.longitude);
    setState(() {
      position = CameraPosition(
          target: LatLng(currentPosition.latitude, currentPosition.longitude),
          zoom: 18);
      centerPin = Marker(
          draggable: true,
          markerId: MarkerId('sourcePin'),
          position: LatLng(currentPosition.latitude,
              currentPosition.longitude), // updated position
          icon: BitmapDescriptor.defaultMarker);
      filteredMarkers.add(centerPin);
      AddMarkers();
    });
  }
}
