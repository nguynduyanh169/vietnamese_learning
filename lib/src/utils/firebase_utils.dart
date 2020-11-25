
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FireBaseUtils {

  static Future<String> uploadFile(File file) async{
    await Firebase.initializeApp();
    String fileUrl;
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('audio_for_user_post')
        .child(basename(file.path) + '_' + DateTime.now().toString());

    UploadTask uploadTask = reference.putFile(file);
    fileUrl = await reference.getDownloadURL();
    // uploadTask.whenComplete(() async {
    //   try {
    //     fileUrl = await reference.getDownloadURL();
    //   } catch (onError) {
    //     print("Error");
    //   }
    //   print(fileUrl);
    // });
  }


}