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
      email: doc[ 'email' ],
      name: doc[ 'name' ],
      bio: doc[ 'bio' ] ?? '',
    );
  }
    Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

}

// class User {
//   String id;
//   String email;
//   String name;

//   User.data(this.id, this.email, this.name) {
//     this.id ??= '';
//     this.name ??= '';
//     this.email ??= '';
//   }

//   factory User.from(representative) => User.data(
//       representative['id'],
//       representative['name'],
//       representative['email']);

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'email': email,
//     };
//   }
// }