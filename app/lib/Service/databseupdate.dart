import 'dart:io';

import 'package:app/utilities/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class DatabesService{
  static Future<String>uploadUserImageProfile(String url, File imageFile)async{
    String photoId = Uuid().v4();
    File image = await compresseImage(photoId,imageFile);
    StorageUploadTask storageUploadTask = storageRef.child('images/users/userProfiel_$photoId.jpg').putFile(image);
    StorageTaskSnapshot storageTaskSnapshot = await storageUploadTask.onComplete;
    String downlodUrl = await storageTaskSnapshot.ref.getDownloadURL();
    return downlodUrl;
  }
  static Future<File>compresseImage(String photoId,File image)async{
    final tempDir = await getTemporaryDirectory();
    final path =tempDir.path;
    File compressedimageFile = await FlutterImageCompress.compressAndGetFile(
      image.absolute.path,
      '$path/im_$photoId.jpg',
      quality: 70,
    );
    return compressedimageFile;
  }
  
}