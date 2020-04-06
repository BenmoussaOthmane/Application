import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Liste extends StatefulWidget {
  @override
  _ListeState createState() => _ListeState();
}

class _ListeState extends State<Liste> {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
   String _currentAddress;
   _getCurrentLocation() {
    // final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
        // print('LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}');
      });
    }).catchError((e) {
      print(e);
    });
    
  }
  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
            print(_currentAddress);
      });
    } catch (e) {
      print(e);
    }
  }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   print('LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}');
  // }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if(_currentAddress != null)
              Text(
                'adres : ${_currentAddress}',
              ),
              FlatButton(
                child: Text(
                  'GetLocation',
                ),
                onPressed: (){
                  _getCurrentLocation();
                  print('LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}');
                  print('LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}');
                },
              )
          ],
        ),
        
      ),
    );
  }
  
}
