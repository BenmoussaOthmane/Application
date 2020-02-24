import 'package:app/Service/auth_service.dart';
import 'package:app/models/user_model.dart';
import 'package:app/screen/Home.dart';
import 'package:app/utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UPdateusers extends StatefulWidget {
  static final String id = 'updateusers';
  final String userId;
  UPdateusers({this.userId});

  @override
  _UPdateusersState createState() => _UPdateusersState();
}

class _UPdateusersState extends State<UPdateusers> {
  final _formKey = GlobalKey<FormState>(); 
  Firestore _firestore = Firestore.instance;
  static final _firebaseAuth = FirebaseAuth.instance;
  String _users ,_name,_email ,_phone;
Future<void> getData(userID) async {
// return await     Firestore.instance.collection('users').document(userID).get();
DocumentSnapshot result = await  Firestore.instance.collection('users').document(userID).get();
return result;

}
// void _userDetails(userID) async {
// final userDetails = getData(userID);
//     setState(() {
//        String firsenam =userDetails.toString();
//        print(firsenam);
//     });
// }
//  Future<void> _userDetails(userID) async {
//         final userDetails = await getData(userID);
//                     setState(() {
//                           firstName =  userDetails.toString();
//                           new Text(firstName);
//         });
//         }
  _submit(){
     if(_formKey.currentState.validate()){
       _formKey.currentState.save();
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
      body:  FutureBuilder<FirebaseUser>(
        future:  _firebaseAuth.currentUser(),
        // hadi ta3 la liste li ghadi nakhdam biha kach nhar tabda mana wtakmal malhih
        builder :(BuildContext context, AsyncSnapshot <FirebaseUser> snapshot){
              

            if(snapshot.connectionState == ConnectionState.done){
            String usersEmail = snapshot.data.uid;
            usersRef.document(usersEmail).snapshots();
            if(snapshot.data == null){
              return Center(
              child: CircularProgressIndicator(),
            );
            }
            print(usersEmail);
            // print(snapshot.data);
          // User user = User.formDoc(snapshot.data);
          // print(snapshot.data);
            
            // User user = User.formDoc(data['name']);
            // print(snapshot.data[]);
            // return Text(
            //   userID
            // );
           
          }
          // print(snapshot.data.data);
          // return Text('${snapshot.data.data}');
          // User user = User.formDoc(snapshot.data);
          // print(user.email);
          

          return Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height:200 ,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(200)
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 30,
                      color: Colors.black26
                    )
                  ],
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/72377054_2431601263788855_84064381272326144_n (1).jpg'),
                  )
                ),
              ),
              SizedBox(height: 10,),
              Form(
                key: _formKey,
                 child:Column(
                   children: <Widget>[
                     Container(
                child: FlatButton(
                      onPressed: ()=> Navigator.pushNamed(context,Home.id),
                      child:Text(
                        'Update Image',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5
                          ),
                      )),
              ),
              Container(
                // height: 20,
                width: MediaQuery.of(context).size.width/1.2,
                // color: Colors.black,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'name',
                    icon: Icon(Icons.person),
                  ),
                  // validator: (input) => input.isEmpty ? 'Format non valid' : null,
                  onSaved: (input) => _users= input,
                ),
              ),
              SizedBox(height: 18,),
              Container(
                // height: 20,
                width: MediaQuery.of(context).size.width/1.2,
                // color: Colors.black,
                child: TextFormField(
                  // initialValue: name,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    icon: Icon(Icons.person),
                  ),
                  // validator: (input) => input.isEmpty ? 'Format non valid' : null,
                  onSaved: (input) => _name= input,
                ),
              ),
              SizedBox(height: 18,),
              Container(
                // height: 20,
                width: MediaQuery.of(context).size.width/1.2,
                // color: Colors.black,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Eamail',
                    icon: Icon(Icons.alternate_email),
                  ),
                  // validator: (input) => !input.contains('@') ? 'Format non valid' : null,
                  onSaved: (input) => _email= input,
                ),
              ),
              SizedBox(height: 18,),
              Container(
                // height: 20,
                width: MediaQuery.of(context).size.width/1.2,
                // color: Colors.black,
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Telephone',
                    icon: Icon(Icons.phone),
                  ),
                  // validator: (input) => input.isEmpty ? 'Format non valid' : null,
                  onSaved: (input) => _phone= input,
                ),
              ),
              SizedBox(height: 30,),
                   ],
                 ),
              ),
              
              Container(
                height: MediaQuery.of(context).size.height/14,
                width: MediaQuery.of(context).size.width/1.4,
                // color: Colors.black,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.1,1.0],
                    colors: [
                      Color(0xFF058416),
                      Color(0xFF4DC15C),
                    ]
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20)
                  )
                ),
                child: FlatButton(
                 onPressed: () => Authservice.logout(context),
                  
                  child:Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2
                    ),
                  )
                  ),
              )
            ],
          ),
        );
        }
      ),
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
