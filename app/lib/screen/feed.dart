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
                   'Email: ${Authservice.emaiiil}'
                 ),
                 SizedBox(height: 50,),
                 Text(
                  'name : ${Authservice.nameee}'
                 )
               ],
              ),
            )
          ),
          
        );
      }
    }