import 'package:app/Service/auth_service.dart';
import 'package:flutter/material.dart';
 


class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
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
                 )
               ],
              ),
            )
          ),
          
        );
      }
    }