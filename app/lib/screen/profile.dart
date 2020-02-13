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
import 'package:app/Animation/FadeAnimation.dart';
import 'package:app/Service/auth_service.dart';
import 'package:app/models/user_model.dart';
import 'package:app/screen/Updateusers.dart';
import 'package:app/screen/login.dart';
import 'package:app/screen/signup.dart';
import 'package:app/utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  final String userId;
  Profile({this.userId});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new FutureBuilder(
        future: usersRef.document(widget.userId).get(),
        builder :(context , snapshot){
            if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
            // print(snapshot.data['email']);
          }
          User user = User.formDoc(snapshot.data);
          print(user.name);
          // print("${user.email}");
          // print(snapshot.data.documents[0]['email']);
          
        return Container(
          // color: Colors.,
          child: Column(
            children: <Widget>[
               FadeAnimation(0.7,Container(
                width: double.infinity,
                height:MediaQuery.of(context).size.height/1.7 ,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                     begin: Alignment.bottomCenter,
                     end: Alignment.topCenter,
                     stops: [0.1,1.0],
                     colors: [
                       Color(0xFF004267),
                       Color(0xFF17D3C2),
                     ]
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(95),
                    bottomRight: Radius.circular(95),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF004267).withOpacity(.9),
                      blurRadius: 40,
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 215,
                      width: 215,
                      decoration: BoxDecoration(
                        color: Colors.black12,                        
                        borderRadius: BorderRadius.all(
                          Radius.circular(200)
                        ),
                        
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 200,
                            width: 200,
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
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                 borderRadius: BorderRadius.all(
                                  Radius.circular(200)
                                  ),
                                gradient: LinearGradient(
                                 begin: Alignment.bottomRight,
                                 end: Alignment.topCenter,
                                 stops: [0.1,0.85],
                                 colors: [
                                   Color(0xFF048C9E).withOpacity(.6),
                                   Color(0xFF048394).withOpacity(.04),
                                 ]
                              ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25,),
                        Container(
                          // height: 50,
                          // // width: 20,
                          // color: Colors.white,
                          child: Text(
                            'othmane',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Arail',
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          
                        ),
                    SizedBox(height: 10,),
                    // PageView(
                    //   children: <Widget>[
                    //     Profile(userId: widget.userId,)
                    //   ],

                    // ),
                    Container(
                      child: Text(
                        'Coder X',
                        // user.name,
                        style: TextStyle(
                          color: Colors.white70,
                          fontFamily: 'Arial',
                          fontSize: 20,
                          letterSpacing: 2
                        ),
                      ),
                    ), 
                    // SizedBox(height: 30,),
                  ],
                ),
              )),
              SizedBox(height: 50,),
              FadeAnimation(0.5,Container(
                height: MediaQuery.of(context).size.height/15,
                width: MediaQuery.of(context).size.width/1.2,
                // color: Colors.black,  MediaQuery.of(context).size.height/1.7 
                decoration: BoxDecoration(
                  color: Color(0xFF11B803),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20)
                  )
                ),
                child: FlatButton(
                  onPressed: ()=> Navigator.pushNamed(context,UPdateusers.id),
                  child: Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Arail',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 2
                    ),
                  ),
                  ),
              )),
              SizedBox(height: 12,),
              FadeAnimation(0.5,Container(
                height: MediaQuery.of(context).size.height/15,
                width: MediaQuery.of(context).size.width/1.2,
                // color: Colors.black,
                decoration: BoxDecoration(
                  border: Border.all(color:Colors.black54),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20)
                  )
                ),
                child: FlatButton(
                  splashColor: Colors.red[50],
                  onPressed: () => Authservice.logout(context),
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.black54,
                      fontFamily: 'Arail',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      letterSpacing: 2
                    ),
                  )
                  )),
              )
           ],
          ),
        );
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
    );
  }
}