import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Liste extends StatefulWidget {
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
