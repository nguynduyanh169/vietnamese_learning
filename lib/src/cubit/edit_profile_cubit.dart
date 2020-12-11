import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/models/nation.dart';
import 'package:vietnamese_learning/src/models/user_profile.dart';
import 'package:vietnamese_learning/src/states/edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState>{
  EditProfileCubit(): super(IntitialEditProfile());

  Future<void> LoadEditProfile() async{
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String username = prefs.getString('username');
      UserProfile userProfile = UserProfile.fromJson(json.decode(prefs.getString(username + 'profile')));
      List<Nation> nationList = new List();
      nationList.add(new Nation(nation: 'Vietnam', image: 'https://firebasestorage.googleapis.com/v0/b/master-vietnamese.appspot.com/o/country%2Fvietnam.png?alt=media&token=4d353d03-50f4-469c-aaa8-96afabb59fd9'));
      nationList.add(new Nation(nation: 'France', image: 'https://firebasestorage.googleapis.com/v0/b/master-vietnamese.appspot.com/o/country%2Ffrance.png?alt=media&token=d01979d1-f5cc-4dcf-a939-86717eb5e7af'));
      nationList.add(new Nation(nation: 'United State', image: 'https://firebasestorage.googleapis.com/v0/b/master-vietnamese.appspot.com/o/country%2Funited-states.png?alt=media&token=15d0039d-e9df-437f-aed7-6b03f2569172'));
      nationList.add(new Nation(nation: 'United Kingdom', image: 'https://firebasestorage.googleapis.com/v0/b/master-vietnamese.appspot.com/o/country%2Funited-kingdom.png?alt=media&token=cea37a6c-2566-4cbf-a5b4-f04b0891998d'));
      nationList.add(new Nation(nation: 'Korea', image: 'https://firebasestorage.googleapis.com/v0/b/master-vietnamese.appspot.com/o/country%2Fsouth-korea.png?alt=media&token=c7c69d25-cc3a-4c43-a54c-bcb647bae90b'));
      emit(LoadedEditProfile(userProfile, nationList));
    }on Exception{
      emit(LoadEditProfileFailed());
    }
  }
}