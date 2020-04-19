import 'package:app/Service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
 

final DateTime date = DateTime.now();
class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  
  double distance;
  int dis;
  double l=52.2165157;
  double k=6.9437819;
  double j=52.3546274;
  double h=4.8285838;
  var geolocator = Geolocator();

  void getDestance()async{
    distance = await geolocator.distanceBetween(l, k, j, h);
    distance = distance/1000;
    dis =distance.round();
    print(dis);
  }

    @override
    void initState() {
    // TODO: implement initState
    print(date);
    getDestance();
    super.initState();
  }
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 120,vertical: 150),
              child: Column(
               children: <Widget>[
                 Text(
                   'Email: ${Authservice.emaiiil}',
                   style: TextStyle(
                     fontFamily: 'BalooTamma2 Regular',
                     fontSize: 20,
                   ),
                 ),
                 SizedBox(height: 50,),
                 Text(
                  'name : ${Authservice.nameee}',
                  style: TextStyle(
                    fontFamily: 'Gotu',
                    fontSize: 30
                  ),
                 ),
                 FlatButton(onPressed: ()=> Authservice.logout(context), child: Text(
                   'LogOut'
                 ))
               ],
              ),
            )
          ),
          
        );
      }
    }