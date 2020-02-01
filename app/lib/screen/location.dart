import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_webservice/places.dart';


class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  GoogleMapController _controller;
  // Completer<GoogleMapController> _controllerr = Completer();
  Position position ,_currentPosition;
  String searchAppr;
  static const LatLng _center = const  LatLng(40.730610,-73.935242);
  final Map<String, Marker> _markers = {};

  void _setStyle(GoogleMapController controller) async {
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/maps_Style.json');
    controller.setMapStyle(value);
  }


// void _getLocation() async {
//     var currentLocation = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
//     setState(() {
//       _markers.clear();
//       final marker = Marker(
//           markerId: MarkerId("curr_loc"),
//           position: LatLng(currentLocation.latitude, currentLocation.longitude),
//           infoWindow: InfoWindow(title: 'Your Location'),
//       );
//       _markers["Current Location"] = marker;
//     });
//   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
           GoogleMap( 
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              scrollGesturesEnabled: true,
              tiltGesturesEnabled: true,
              rotateGesturesEnabled: true,
              compassEnabled: true,
              markers: _creatMarker(),
              initialCameraPosition: CameraPosition(
                bearing: 192.8334901395799,
                target: _center,
                zoom: 11.0,
              ),
            ),
            
            Positioned(
              top: 50,
              right: 15,
              left: 15,
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white
                ),
                child: TextField(
                  // onTap: ()async{
                  //   Prediction prediction = await PlacesAutocomplete.show(context: null,apiKey: 'AIzaSyDcGlwp1UaghdNbmq1AmyVWUwhWcUqJK3Y',
                  //     language: "EN",
                  //     components: [
                  //       Component(
                  //         Component.country,"EN"
                  //       )
                  //     ]
                  //   );
                  // },
                  decoration: InputDecoration(
                    hintText: 'Entre Adress ',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0,top:15.0 ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: shearchandNavigation,
                      iconSize: 30,
                      )
                  ),
                  onChanged: (val){
                    setState(() {
                      searchAppr = val;
                    });
                  },
                ),
              ),
            ),
        ],
      ),  
    );
  }


  shearchandNavigation(){
    Geolocator().placemarkFromAddress(searchAppr).then((result){
      _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: 
              LatLng(result[0].position.latitude, result[0].position.longitude),
              zoom: 12.0,
         )
      ));
    });

  }
  void _onMapCreated(controller){
    _controller=controller;
    _setStyle(controller);
  }
  Set<Marker> _creatMarker(){
    var tmp = Set<Marker>();
    tmp.add(
      Marker(
        markerId: MarkerId("formPoint"),
        position: _center
      )
    );
    return tmp;
  }
   _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }
}


