import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Liste extends StatefulWidget {
  static Position cp = null;
  @override
  _ListeState createState() => _ListeState();
}

class _ListeState extends State<Liste> {
  Position _currentPosition;
   _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        Liste.cp=_currentPosition;
        // print('LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}');
      });
    }).catchError((e) {
      print(e);
    });
    
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
            if(_currentPosition != null)
              Text(
                'LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}',
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
