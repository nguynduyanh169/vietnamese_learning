import 'package:flutter/material.dart';

class ColorConstants{
  static const kBackgroundColor = Color(0xFFF8F8F8);
  static const kActiveIconColor = Color(0xFFE68342);
  static const kTextColor = Color(0xFF222B45);
  static const kBlueLightColor = Color(0xFFC7B8F5);
  static const kBlueColor = Color(0xFF817DC0);
  static const kShadowColor = Color(0xFFE6E6E6);

}

class APIConstants{
  static const String BASE_URL = "https://master-vietnamese.azurewebsites.net";
  static const String BASE_URL_HEROKU = "https://vn-master.herokuapp.com";
  static const String GET_COMMENTS = BASE_URL + "/api/comment/";
  static const String CREATE_COMMENT = BASE_URL + "/api/comment";
  static const String DELETE_COMMENT = BASE_URL + "/api/comment";
  static const String CONVERSATION = BASE_URL + "/api/conversation/getByLesson/";
  static const String ENTRANCE_QUIZ = BASE_URL + "/api/question";
  static const String GAME = BASE_URL + "/api/vocabulary/loadGame/";
  static const String LESSONS_BY_LEVEL = BASE_URL + "/api/lessons";
  static const String CREATE_POST = BASE_URL + "/api/post";
  static const String GET_POST = BASE_URL + "/api/post";
  static const String GET_NEXT_POST = BASE_URL + "/api/post/nextPost";
  static const String GET_MY_POST = BASE_URL + "/api/post/myPost";
  static const String UPDATE_POST = BASE_URL + "/api/post";
  static const String DELETE_POST = BASE_URL + "/api/post";
  static const String SEARCH_POSTS = BASE_URL + "/api/post/search";
  static const String CREATE_PROCESS =  BASE_URL + "/api/progress/createProgress";
  static const String GET_QUIZ = BASE_URL + "/api/quiz/";
  static const String GET_QUESTIONS = BASE_URL + "/api/question/getByQuiz/";
  static const String SUBMIT_QUIZ = BASE_URL + "/api/history";
  static const String LOGIN = BASE_URL + "/api/authen/login";
  static const String REGISTER = BASE_URL_HEROKU + "/api/authen/signup";
  static const String GET_PROFILE = BASE_URL + "/api/authen/getUserDetail";
  static const String SEND_EMAIL = BASE_URL + "/api/authen/forget";
  static const String CHANGE_PASSWORD = BASE_URL + "/api/authen/updateNewPassword";
  static const String LOGIN_GMAIL = BASE_URL + "/api/authen/signin-gmail";
  static const String EDIT_PROFILE = BASE_URL + "/api/authen/editProfile";
  static final String VOCABULARY = BASE_URL + "/api/vocabulary/getByLesson/";
}

class HiveBoxName{
  static const String CACHE_FILE_BOX = 'CacheFile';
  static const String PROGRESS_BOX = 'Progress';
  static const String JSON_BOX = 'JSON';
}