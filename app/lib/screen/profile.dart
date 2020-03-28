// import 'package:app/Animation/FadeAnimation.dart';
// import 'package:app/Service/auth_service.dart';
// import 'package:app/models/user_model.dart';
// import 'package:app/screen/Updateusers.dart';
// import 'package:app/screen/login.dart';
// import 'package:app/screen/signup.dart';
// import 'package:app/utilities/constants.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class Profile extends StatefulWidget {
//   final String userId;
//   Profile({this.userId});
//   @override
//   _ProfileState createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         future:usersRef.document(widget.userId).get(),
//         builder :( context , snapshot){
//             if(!snapshot.hasData){
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//             // print(snapshot.data['email']);
//           }
//           // User user = User.formDoc(snapshot.data);
//           // print(user.name);
          
//           print(snapshot.data);
          
//         return Container(
//           // color: Colors.,
//           child: Column(
//             children: <Widget>[
//                FadeAnimation(0.7,Container(
//                 width: double.infinity,
//                 height:MediaQuery.of(context).size.height/1.7 ,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                      begin: Alignment.bottomCenter,
//                      end: Alignment.topCenter,
//                      stops: [0.1,1.0],
//                      colors: [
//                        Color(0xFF004267),
//                        Color(0xFF17D3C2),
//                      ]
//                   ),
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(95),
//                     bottomRight: Radius.circular(95),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color(0xFF004267).withOpacity(.9),
//                       blurRadius: 40,
//                     )
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Container(
//                       height: 215,
//                       width: 215,
//                       decoration: BoxDecoration(
//                         color: Colors.black12,                        
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(200)
//                         ),
                        
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Container(
//                             height: 200,
//                             width: 200,
//                             // color: Colors.white,
//                             decoration: BoxDecoration(
//                             color: Colors.white,                        
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(200)
//                             ),
//                             image: DecorationImage(
//                               fit: BoxFit.cover,
//                               image: AssetImage('assets/images/72377054_2431601263788855_84064381272326144_n (1).jpg'),
//                             )
//                             ),
//                             child: Container(
//                               height: 200,
//                               width: 200,
//                               decoration: BoxDecoration(
//                                  borderRadius: BorderRadius.all(
//                                   Radius.circular(200)
//                                   ),
//                                 gradient: LinearGradient(
//                                  begin: Alignment.bottomRight,
//                                  end: Alignment.topCenter,
//                                  stops: [0.1,0.85],
//                                  colors: [
//                                    Color(0xFF048C9E).withOpacity(.6),
//                                    Color(0xFF048394).withOpacity(.04),
//                                  ]
//                               ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 25,),
//                         Container(
//                           // height: 50,
//                           // // width: 20,
//                           // color: Colors.white,
//                           child: Text(
//                             snapshot.data.documents[0]['name'],
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontFamily: 'Arail',
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold
//                             ),
//                           ),
                          
//                         ),
//                     SizedBox(height: 10,),
//                     // PageView(
//                     //   children: <Widget>[
//                     //     Profile(userId: widget.userId,)
//                     //   ],

//                     // ),
//                     Container(
//                       child: Text(
//                         'Coder X',
//                         // user.name,
//                         style: TextStyle(
//                           color: Colors.white70,
//                           fontFamily: 'Arial',
//                           fontSize: 20,
//                           letterSpacing: 2
//                         ),
//                       ),
//                     ), 
//                     // SizedBox(height: 30,),
//                   ],
//                 ),
//               )),
//               SizedBox(height: 50,),
//               FadeAnimation(0.5,Container(
//                 height: MediaQuery.of(context).size.height/15,
//                 width: MediaQuery.of(context).size.width/1.2,
//                 // color: Colors.black,  MediaQuery.of(context).size.height/1.7 
//                 decoration: BoxDecoration(
//                   color: Color(0xFF11B803),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(20)
//                   )
//                 ),
//                 child: FlatButton(
//                   onPressed: ()=> Navigator.pushNamed(context,UPdateusers.id),
//                   child: Text(
//                     'Update',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontFamily: 'Arail',
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20,
//                       letterSpacing: 2
//                     ),
//                   ),
//                   ),
//               )),
//               SizedBox(height: 12,),
//               FadeAnimation(0.5,Container(
//                 height: MediaQuery.of(context).size.height/15,
//                 width: MediaQuery.of(context).size.width/1.2,
//                 // color: Colors.black,
//                 decoration: BoxDecoration(
//                   border: Border.all(color:Colors.black54),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(20)
//                   )
//                 ),
//                 child: FlatButton(
//                   splashColor: Colors.red[50],
//                   onPressed: () => Authservice.logout(context),
//                   child: Text(
//                     'Log Out',
//                     style: TextStyle(
//                       color: Colors.black54,
//                       fontFamily: 'Arail',
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20,
//                       letterSpacing: 2
//                     ),
//                   )
//                   )),
//               )
//            ],
//           ),
//         );
//         },
//       ),
//       // body: Container(
//       //   child: Column(
//       //     children: <Widget>[
//       //       Padding(
//       //         padding: const EdgeInsets.all(150),
//       //         child: Text(
//       //           'Profile'
//       //         ),
//       //       ),
//       //       SizedBox(height: 50),
//       //       Container(
//       //         child: FlatButton(
//       //           child: Text(
//       //             'Deconection'
//       //           ),
//       //           onPressed: () => Authservice.logout(context),
//       //         ),
//       //       )
//       //     ],
//       //   ),
//       // ),
//       // image: DecorationImage(
//       //                 fit: BoxFit.cover,
//       //                 image: AssetImage('assets/images/72377054_2431601263788855_84064381272326144_n (1).jpg'),
//       //               )
//     );
//   }
// }
import 'dart:io';
import 'dart:math';

import 'package:app/Animation/FadeAnimation.dart';
import 'package:app/Service/auth_service.dart';
import 'package:app/models/user_model.dart';
import 'package:app/screen/Home.dart';
import 'package:app/screen/Updateusers.dart';
import 'package:app/screen/login.dart';
import 'package:app/screen/signup.dart';
import 'package:app/utilities/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as prefix0;

class Profile extends StatefulWidget {
  final String userId;
  Profile({this.userId});


  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String useremail ='';
 static final _firebaseAuth = FirebaseAuth.instance;
  File _profileImage;

  @override
  void initState(){
    super.initState();
    _refrichi();
    setState(() {
    });
  }
  
  _handelImageNetwork()async{
    File imageFile = await prefix0.ImagePicker.pickImage(source: prefix0.ImageSource.gallery);
    if(imageFile != null){
      setState(() {
        _profileImage = imageFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refrichi,
              child: FutureBuilder(
                // future:  _firebaseAuth.currentUser(),
                future: usersRef.document(widget.userId).get(),
                builder :( context,  snapshot){
                      if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                      ),
                    );
                  }
                  // User user  = User.fromDocument(snapshot.data);
                return Container(
                  // color: Colors.,
                  child: Column(
                    children: <Widget>[
                       FadeAnimation(0.1,Container(
                        width: double.infinity,
                        height:MediaQuery.of(context).size.height/1.45 ,
                        decoration: BoxDecoration(
                         color: Colors.grey[300],
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(95),
                            bottomRight: Radius.circular(95),
                          ),
                          boxShadow: [
                                   BoxShadow(
                                     color: Colors.grey[600],
                                     offset: Offset(4.0,4.0),
                                     blurRadius: 15.0,
                                     spreadRadius: 1.0,
                                   ),
                                   BoxShadow(
                                     color: Colors.white,
                                     offset: Offset(-4.0,-4.0),
                                     blurRadius: 15.0,
                                     spreadRadius: 1.0,
                                   )
                                 ],
                                 gradient: LinearGradient(
                                   begin:Alignment.topLeft ,
                                   end: Alignment.bottomRight,
                                   colors: [
                                     Colors.grey[200],
                                     Colors.grey[300],
                                     Colors.grey[400],
                                     Colors.grey[500],
                                   ],
                                   stops: [
                                     0.1,
                                     0.3,
                                     0.8,
                                     0.9
                                   ]
                                 )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: MediaQuery.of(context).size.height/4.2,
                              width:  MediaQuery.of(context).size.height/4.2,
                              decoration: BoxDecoration(
                                color: Colors.black12,                        
                                borderRadius: BorderRadius.all(
                                  Radius.circular(200)
                                ),
                                
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  // CircleAvatar(
                                  //   radius: 100,
                                  //   backgroundColor: Colors.grey,
                                  //   backgroundImage: user.profileImageUrl.isEmpty
                                  //   ? AssetImage('assets/images/72377054_2431601263788855_84064381272326144_n (1).jpg')
                                  //   :CachedNetworkImageProvider(user.profileImageUrl)
                                  // )
                                  Container(
                                    height:  MediaQuery.of(context).size.height/4.4,
                                    width:  MediaQuery.of(context).size.height/4.4,
                                    // color: Colors.white,
                                    decoration: BoxDecoration(
                                    color: Colors.white,                        
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(200)
                                    ),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage('assets/images/72377054_2431601263788855_84064381272326144_n (1).jpg'),
                                    )
                                    ),
                                    child: Container(
                                      height:  MediaQuery.of(context).size.height/4.4,
                                      width:  MediaQuery.of(context).size.height/4.4,
                                      decoration: BoxDecoration(
                                         borderRadius: BorderRadius.all(
                                          Radius.circular(200)
                                          ),
                                        gradient: LinearGradient(
                                         begin: Alignment.bottomRight,
                                         end: Alignment.topCenter,
                                         stops: [0.1,0.85],
                                         colors: [
                                           Colors.grey.withOpacity(.6),
                                           Colors.grey.withOpacity(.04),
                                         ]
                                      ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height:  MediaQuery.of(context).size.height/20,),
                                Container(
                                  // height: 50,
                                  // // width: 20,
                                  // color: Colors.white,
                                  child: Text(
                                    Home.y,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Arail',
                                      fontSize: 23,
                                      letterSpacing: 3,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  
                                ),
                            // SizedBox(height: 10,),
                            // PageView(
                            //   children: <Widget>[
                            //     Profile(userId: widget.userId,)
                            //   ],
        
                            // ),
                            // Container(
                            //   child: Text(
                            //     'Coder X',
                            //     // user.name,
                            //     style: TextStyle(
                            //       color: Colors.white70,
                            //       fontFamily: 'Arial',
                            //       fontSize: 20,
                            //       letterSpacing: 2
                            //     ),
                            //   ),
                            // ), 
                            // SizedBox(height: 30,),
                          ],
                        ),
                      )),
                      // SizedBox(height: 50,),
                      // FadeAnimation(0.5,Container(
                      //   height: MediaQuery.of(context).size.height/15,
                      //   width: MediaQuery.of(context).size.width/1.2,
                      //   // color: Colors.black,  MediaQuery.of(context).size.height/1.7 
                      //   decoration: BoxDecoration(
                      //     color: Color(0xFF11B803),
                      //     borderRadius: BorderRadius.all(
                      //       Radius.circular(20)
                      //     )
                      //   ),
                      //   child: FlatButton(
                      //     onPressed: ()=> Navigator.pushNamed(context,UPdateusers.id),
                      //     child: Text(
                      //       'Update',
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         fontFamily: 'Arail',
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 20,
                      //         letterSpacing: 2
                      //       ),
                      //     ),
                      //     ),
                      // )),
                      // SizedBox(height: 12,),
                      // FadeAnimation(0.5,Container(
                      //   height: MediaQuery.of(context).size.height/15,
                      //   width: MediaQuery.of(context).size.width/1.2,
                      //   // color: Colors.black,
                      //   decoration: BoxDecoration(
                      //     border: Border.all(color:Colors.red),
                      //     borderRadius: BorderRadius.all(
                      //       Radius.circular(20)
                      //     )
                      //   ),
                      //   child: FlatButton(
                      //     splashColor: Colors.red[50],
                      //     onPressed: () => Authservice.logout(context),
                      //     child: Text(
                      //       'Log Out',
                      //       style: TextStyle(
                      //         color: Colors.red,
                      //         fontFamily: 'Arail',
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 20,
                      //         letterSpacing: 2
                      //       ),
                      //     )
                      //     )),
                      // )
                      SizedBox(height: MediaQuery.of(context).size.height/80,),
        
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 22),
                        child: FadeAnimation(1.3,Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height/11.5,
                                width: MediaQuery.of(context).size.width/5,
                                decoration: BoxDecoration(
                                 color: Colors.grey[300],
                                 shape: BoxShape.circle,
                                 boxShadow: [
                                   BoxShadow(
                                     color: Colors.grey[600],
                                     offset: Offset(4.0,4.0),
                                     blurRadius: 15.0,
                                     spreadRadius: 1.0,
                                   ),
                                   BoxShadow(
                                     color: Colors.white,
                                     offset: Offset(-4.0,-4.0),
                                     blurRadius: 15.0,
                                     spreadRadius: 1.0,
                                   )
                                 ],
                                 gradient: LinearGradient(
                                   begin:Alignment.topLeft ,
                                   end: Alignment.bottomRight,
                                   colors: [
                                     Colors.grey[200],
                                     Colors.grey[300],
                                     Colors.grey[400],
                                     Colors.grey[500],
                                   ],
                                   stops: [
                                     0.1,
                                     0.3,
                                     0.8,
                                     0.9
                                   ]
                                 )
                                ),
                                child: IconButton(
                                  icon:Icon(Icons.settings,
                                  color: Colors.black54,
                                  size: 35,
                                  ),
                                  onPressed: ()=> Navigator.pushNamed(context,UPdateusers.id),
                                  ),
                              ),
                              Container(
                                height:MediaQuery.of(context).size.height/11.5,
                                width: MediaQuery.of(context).size.width/5,
                                decoration: BoxDecoration(
                                 color: Colors.grey[300],
                                 shape: BoxShape.circle,
                                 boxShadow: [
                                   BoxShadow(
                                     color: Colors.grey[600],
                                     offset: Offset(4.0,4.0),
                                     blurRadius: 15.0,
                                     spreadRadius: 1.0,
                                   ),
                                   BoxShadow(
                                     color: Colors.white,
                                     offset: Offset(-4.0,-4.0),
                                     blurRadius: 15.0,
                                     spreadRadius: 1.0,
                                   )
                                 ],
                                 gradient: LinearGradient(
                                   begin:Alignment.topLeft ,
                                   end: Alignment.bottomRight,
                                   colors: [
                                     Colors.grey[200],
                                     Colors.grey[300],
                                     Colors.grey[400],
                                     Colors.grey[500],
                                   ],
                                   stops: [
                                     0.1,
                                     0.3,
                                     0.8,
                                     0.9
                                   ]
                                 )
                                ),
                                child: IconButton(
                                  icon:Icon(Icons.camera,
                                  color: Colors.black54,
                                  size: 35,
                                  ),
                                  onPressed: _handelImageNetwork
                                  ),
                              ),
                            ],     
                        )
                      ),
                      ),
                      // SizedBox(height: ,),
                     FadeAnimation(2,Container(
                        height:MediaQuery.of(context).size.height/12,
                        width: MediaQuery.of(context).size.width/2.5,
                        decoration: BoxDecoration(
                                 color: Colors.red[200],
                                 borderRadius: BorderRadius.all(Radius.circular(50)),
                                 boxShadow: [
                                   BoxShadow(
                                     color: Colors.red[600],
                                     offset: Offset(4.0,4.0),
                                     blurRadius: 15.0,
                                     spreadRadius: 1.0,
                                   ),
                                   BoxShadow(
                                     color: Colors.white,
                                     offset: Offset(-4.0,-4.0),
                                     blurRadius: 15.0,
                                     spreadRadius: 1.0,
                                   )
                                 ],
                                 gradient: LinearGradient(
                                   begin:Alignment.topLeft ,
                                   end: Alignment.bottomRight,
                                   colors: [
                                     Colors.red[200],
                                     Colors.red[300],
                                     Colors.red[400],
                                     Colors.red[500],
                                   ],
                                   stops: [
                                     0.1,
                                     0.3,
                                     0.8,
                                     0.9
                                   ]
                                 )
                                ),
                                child: IconButton(
                                  icon:Icon(Icons.exit_to_app,
                                  color: Colors.white,
                                  size: 35,
                                  ),
                                  onPressed: () => Authservice.logout(context),
                                  ),
                      )
                  ),
                   ],
                  ),
                )
                ;
                },
              ),
                    
                  
              
              // body: Container(
              //   child: Column(
              //     children: <Widget>[
              //       Padding(
              //         padding: const EdgeInsets.all(150),
              //         child: Text(
              //           'Profile'
              //         ),
              //       ),
              //       SizedBox(height: 50),
              //       Container(
              //         child: FlatButton(
              //           child: Text(
              //             'Deconection'
              //           ),
              //           onPressed: () => Authservice.logout(context),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              // image: DecorationImage(
              //                 fit: BoxFit.cover,
              //                 image: AssetImage('assets/images/72377054_2431601263788855_84064381272326144_n (1).jpg'),
              //               )
            )
            );
          }
        
          Future<void> _refrichi() async{
            await Future.delayed(Duration(seconds: 3));
            // print('object');
          }
          @override
          Widget ref(BuildContext context, AsyncSnapshot snapshot){
            // print('object');
             FutureBuilder(
                // future:  _firebaseAuth.currentUser(),
                future: usersRef.document(widget.userId).get(),
                builder :(BuildContext context, AsyncSnapshot snapshot){
                  // print('object');
                  if (snapshot.connectionState == ConnectionState.done) {
                      if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                    // print(snapshot.data['email']);
                  }
                  // useremail = snapshot.data.email;
                  // print(useremail);
                  // print(usersEmail);
                  }
                  // User user = User.formDoc(snapshot.data);
                  // print(user.name);
                  // print(user.bio);
                  // print('object');
                }
                );
                // print('troi');
                
          }
}