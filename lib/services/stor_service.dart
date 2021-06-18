import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StoreService {
  static final _storage =FirebaseStorage.instance.ref();
  static final folder = 'post_model';

  static Future<String> uploadImage(File _image) async {
    String image_name = 'image_' + DateTime.now().toString();
    StorageReference firebaseStorageRef =_storage.child(folder).child(image_name);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

    if (taskSnapshot != null) {
      final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      print(downloadUrl);
      return downloadUrl;
    }
    return null;
  }
}