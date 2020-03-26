import 'package:app/models/user_model.dart';
import 'package:app/utilities/constants.dart';

class DatabesService{
  static void updateUser(User user){
    usersRef.document(user.bio).updateData({
      'name': user.name,
      'profileImageUrl' : user.profileImageUrl,
      'bio': user.bio,
    });
  }
}