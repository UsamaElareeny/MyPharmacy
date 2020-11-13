import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController mapController;

  LatLng _center =  LatLng(0, 0);

  final Map<String, Marker> _markers = {};
  getNearServices() async {
    LocationData locData = await Location().getLocation();
    _center = LatLng(locData.latitude, locData.longitude);
    final snapshot =
        await Firestore.instance.collection('Pharmacies').getDocuments();
    final documents = snapshot.documents;
    documents.forEach((element) {
      final points = element['locations'] as List<dynamic>;
      print('CARD:$points');
      for (GeoPoint locationPoint in points) {
        print('loc:${locationPoint}');
        final id = '${element.documentID}${locationPoint.longitude}';
        final marker = Marker(
          markerId: MarkerId(id),
          position: LatLng(locationPoint.latitude, locationPoint.longitude),
          infoWindow: InfoWindow(
            title: element['name'],
          ),
        );
        _markers['${element['name']} $id'] = marker;

      }
    });
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController  = controller;
    await getNearServices();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Pharmacies Location'),
          backgroundColor: Colors.green[700],
        ),
        body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            return GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
              markers: _markers.values.toSet(),
            );
          },
          future: getNearServices(),
        ),
      ),
    );
  }
}
