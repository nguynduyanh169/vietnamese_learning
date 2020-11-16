
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FireBaseUtils {

  static Future<String> uploadFile(File file) async{
    await Firebase.initializeApp();
    String url;
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('audio_for_user_post')
        .child(basename(file.path) + '_' + DateTime.now().toString());

    UploadTask uploadTask = reference.putFile(file);
    uploadTask.whenComplete(() async {
      try {
        url = await reference.getDownloadURL();
      } catch (onError) {
        print("Error");
      }
      return url;
    });
  }
}