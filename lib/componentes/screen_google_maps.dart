import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geocoder/geocoder.dart';

class ScreenGoogleMaps extends StatefulWidget {
  @override
  _ScreenGoogleMapsState createState() => _ScreenGoogleMapsState();
}

class _ScreenGoogleMapsState extends State<ScreenGoogleMaps> {
  Set<Marker> _markers = {};
  var _lat;
  var _log;

  void _setLatLog(Coordinates coordinates) {
    _lat = coordinates.latitude;
    _log = coordinates.longitude;
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('id-1'),
          position: LatLng(_lat, _log),
          infoWindow: InfoWindow(title: '', snippet: 'Nome: Lucas Fontenele')));
    });
  }

  @override
  Widget build(BuildContext context) {
    final latLog = ModalRoute.of(context).settings.arguments as Coordinates;

    _setLatLog(latLog);
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
      ),
      body: latLog == null
          ? Center(
              child: Text('Erro'),
            )
          : GoogleMap(
              onMapCreated: _onMapCreated,
              markers: _markers,
              initialCameraPosition: CameraPosition(
                target: LatLng(_lat, _log),
                zoom: 15,
              ),
            ),
    );
  }
}
