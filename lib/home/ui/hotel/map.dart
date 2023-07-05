import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPage extends StatefulWidget {
  const LocationPage(
      {Key? key, this.latitude, this.longitude, this.name, this.description})
      : super(key: key);
  final latitude;
  final longitude;
  final name;
  final description;
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late GoogleMapController mapController;
  Map<String, Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(widget.latitude, widget.longitude), zoom: 14),
            onMapCreated: (controller) {
              addMarker(
                  'hotel_location',
                  LatLng(widget.latitude, widget.longitude),
                  BitmapDescriptor.defaultMarker,
                  widget.name,
                  widget.description);
              mapController = controller;
            },
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapToolbarEnabled: true,
            markers: _markers.values.toSet(),
          ),
        ],
      ),
    );
  }

  addMarker(
      String Id, LatLng location, var markIcons, String title, String snippet) {
    //var markIcons =   BitmapDescriptor.defaultMarker;
    var marker = Marker(
      markerId: MarkerId(Id),
      position: location,
      icon: markIcons,
      infoWindow: InfoWindow(title: title, snippet: snippet),
    );

    _markers[Id] = marker;
    setState(() {});
  }
}
