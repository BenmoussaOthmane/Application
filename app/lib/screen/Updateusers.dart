import 'dart:io';

import 'package:app/Service/auth_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UPdateusers extends StatefulWidget {
  static final String id = 'updateusers';
  // final String userId;
  // UPdateusers({this.userId});

  @override
  _UPdateusersState createState() => _UPdateusersState();
}

class _UPdateusersState extends State<UPdateusers> {
    File _profileImage;

    _handelImageNetwork()async{
    File imageFile = await ImagePicker.pickImage(source:ImageSource.gallery);
    if(imageFile != null){
      setState(() {
        _profileImage = imageFile;
      });
    }
  }
  displayProfiel(){
    if(_profileImage == null){
        if(Authservice.imagee.isEmpty){
          return AssetImage('assets/images/72377054_2431601263788855_84064381272326144_n (1).jpg');
        }else{
          return CachedNetworkImageProvider(Authservice.imagee);
        }
    }else{
      return FileImage(_profileImage);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F4F4),

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Update Users',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: displayProfiel(),
            ),
            SizedBox(height: 20,),
            Container(
              height: 50,
              width: 50,
              child: FlatButton(
                onPressed: _handelImageNetwork,
                child:Text(
                  'submite'
                )),
            )
          ],
        )
      )
        
        
    );
  }
}


  // if (snapshot.hasError)
  //         return new Text('Error: ${snapshot.error}');
  //       switch (snapshot.connectionState) {
  //         case ConnectionState.waiting: return new Text('Loading...');
  //         default:
            
          
            
  //           return new ListView(
  //             children: snapshot.data.documents.map((DocumentSnapshot document) {
  //               return new ListTile(
  //                 title: new Text(document['email']),
  //                 subtitle: new Text(document['name']),
  //               );
  //             }).toList(),
  //             );

//////////////////////////////////////////////////


      //  hnaya sat ghir ki njib email//////////
  //  body: new FutureBuilder<FirebaseUser>(
  //       future:  _firebaseAuth.currentUser(),
  //       // hadi ta3 la liste li ghadi nakhdam biha kach nhar tabda mana wtakmal malhih
  //       builder :(BuildContext context, AsyncSnapshot <FirebaseUser> snapshot){
              

  //           if(snapshot.connectionState == ConnectionState.done){
  //           String usersEmail = snapshot.data.email;
  //           String usersName = snapshot.data.toString();
  //           print(usersEmail);
  //           print(usersName);
  //           // User user = User.formDoc(data['name']);
  //           // print(snapshot.data[]);
  //           // return Text(
  //           //   userID
  //           // );
           
  //         }

