import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String id;
  final String email;
  final String name;
  final String bio;

  User({
     this.id,
     this.email,
     this.name,
     this.bio,
    });
  factory User.formDoc(DocumentSnapshot doc){
    return User(
      id: doc.documentID,
      email: doc['email'],
      name: doc['name'],
      bio: doc['bio'] ?? ''
    );
  }

}