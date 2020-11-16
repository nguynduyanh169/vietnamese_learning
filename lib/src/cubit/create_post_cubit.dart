
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/post_repository.dart';
import 'package:vietnamese_learning/src/models/post.dart';
import 'package:vietnamese_learning/src/states/create_post_state.dart';

import '../utils/firebase_utils.dart';

class CreatePostCubit extends Cubit<CreatePostState>{
  final PostRepository _postRepository;
  CreatePostCubit(this._postRepository): super(Init());

  Future<void> createPost({String content, String title, File file}) async{
    DateTime dateTime = DateTime.now();
    PostSave postSave = new PostSave(postDate: dateTime.toIso8601String(), title: title, text: content);
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      emit(CreatingPost());
      String fileUrl = await FireBaseUtils.uploadFile(file);
      bool check = await _postRepository.createPost(token, postSave);
      if (check == true) {
        emit(CreatePostSuccess(fileUrl));
      } else if (check == false) {
        emit(CreatePostError());
      }
    } on Exception {
      emit(CreatePostError());
    }
  }
}