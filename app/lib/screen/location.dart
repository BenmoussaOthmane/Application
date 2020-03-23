import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:app/screen/liste.dart';
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
  static Position position ,_currentPosition,cp;
  String searchAppr;
  static const kGoogleApiKey = "AIzaSyDcGlwp1UaghdNbmq1AmyVWUwhWcUqJK3Y";
  static double ln =Liste.cp.latitude;
  static double lnn = Liste.cp.longitude;
  double lnccn = 0;
  LatLng _center = LatLng(0,0);
  final Map<String, Marker> _markers = {};

  void _setStyle(GoogleMapController controller) async {
    String value = await DefaultAssetBundle.of(context)
        .loadString('assets/maps_Style.json');
    controller.setMapStyle(value);
  }
   
  void _getCur()async{
     final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _controller.animateCamera(CameraUpdate.newCameraPosition(
       CameraPosition(
         target: LatLng(position.latitude,position.longitude),
         zoom: 16.0,
       )
     )
     );
   }


   @override
   void initState(){
     super.initState();
     _getCur();
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
           GoogleMap( 
              myLocationEnabled: true,
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
                zoom: 16.0,
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
            Positioned(
              top: 150,
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
                  onTap:()async{
                    Prediction p = await PlacesAutocomplete.show(
                          context: context,
                          apiKey: kGoogleApiKey,
                          mode: Mode.overlay, // Mode.fullscreen
                          language: "fr",
                          components: [new Component(Component.country, "fr")]);

                  },
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
                ),
              ),
            ),
            // SizedBox(height: 10,width: 50,),
            // Padding(
            //   padding: const EdgeInsets.all(200.0),
            //   child: Container(
            //     height: 100,
            //     width: 100,
            //     color: Colors.amber,
            //     child: FlatButton(
            //       onPressed: _getCur,
            //       child:Text(
            //         'Posiont'
            //       )),
            //   ),
            // )
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
              zoom: 16.0,
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
}


