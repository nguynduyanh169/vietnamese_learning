import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:path/path.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/post_repository.dart';
import 'package:vietnamese_learning/src/models/post.dart';
import 'package:vietnamese_learning/src/states/edit_post_state.dart';

class EditPostCubit extends Cubit<EditPostState>{
  PostRepository _postRepository;

  EditPostCubit(this._postRepository): super(InitialEditPost());

  Future<void> editPost(PostUpdate postUpdate, File file) async{
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      String fileUrl;
      bool check;
      emit(EditingPost());
      if(file == null){
        check = await _postRepository.editPost(token, postUpdate);
        if (check == true) {
          emit(EditPostSuccess());
        } else if (check == false) {
          emit(EditPostFailed());
        }
      }else {
        await Firebase.initializeApp();
        Reference reference = FirebaseStorage.instance
            .ref()
            .child('audio_for_user_post')
            .child(basename(file.path) + '_' + DateTime.now().toString());

        UploadTask uploadTask = reference.putFile(file);
        uploadTask.whenComplete(() async {
          try {
            fileUrl = await reference.getDownloadURL();
            print(fileUrl);
            postUpdate.link = fileUrl;
            check = await _postRepository.editPost(token, postUpdate);
            if (check == true) {
              emit(EditPostSuccess());
            } else if (check == false) {
              emit(EditPostFailed());
            }
          } catch (onError) {
            print("Error");
          }
          print(fileUrl);
        });
      }
    } on Exception {
      emit(EditPostFailed());
    }
  }
}