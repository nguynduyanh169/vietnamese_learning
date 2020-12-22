import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vietnamese_learning/src/data/user_repository.dart';
import 'package:vietnamese_learning/src/models/nation.dart';
import 'package:vietnamese_learning/src/models/user_profile.dart';
import 'package:vietnamese_learning/src/states/edit_profile_state.dart';
import 'package:path/path.dart';


class EditProfileCubit extends Cubit<EditProfileState>{
  UserRepository _userRepository;
  EditProfileCubit(this._userRepository): super(IntitialEditProfile());

  Future<void> LoadEditProfile() async{
    emit(LoadingEditProfile());
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
      nationList.add(new Nation(nation: 'Japan', image: 'https://firebasestorage.googleapis.com/v0/b/master-vietnamese.appspot.com/o/country%2Fjapan.png?alt=media&token=8792c7c8-2719-4cf1-9dbc-3043cdb8b59a'));
      nationList.add(new Nation(nation: 'Germany', image: 'https://firebasestorage.googleapis.com/v0/b/master-vietnamese.appspot.com/o/country%2Fgermany.png?alt=media&token=0accf5ad-2e96-41b8-8572-e5e766cedd2b'));
      nationList.add(new Nation(nation: 'China', image: 'https://firebasestorage.googleapis.com/v0/b/master-vietnamese.appspot.com/o/country%2Fchina.png?alt=media&token=de3069c8-b177-418b-828e-32683c6d176b'));
      if(userProfile == null){
        emit(LoadEditProfileFailed());
      }else {
        emit(LoadedEditProfile(userProfile, nationList));
      }
    }on Exception{
      emit(LoadEditProfileFailed());
    }
  }

  Future<void> editProfile(UserProfile userProfile, File avatar) async{
    emit(EditingProfile());
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('accessToken');
      bool check;
      if(avatar == null){
        EditUser editUser = new EditUser(avatarLink: userProfile.avatar, email: userProfile.email, fullname: userProfile.fullname, nationLink: userProfile.nation);
        check = await _userRepository.editProfile(token, editUser);
        if(check == false){
          emit(EditProfileFailed());
        }else{
          emit(EditProfileSuccess());
        }
      }else{
        await Firebase.initializeApp();
        Reference reference = FirebaseStorage.instance
            .ref()
            .child('audio_for_user_post')
            .child(userProfile.username +
            "/" +
            basename(avatar.path) +
            '_' +
            DateTime.now().toString());
        UploadTask uploadTask = reference.putFile(avatar);
        uploadTask.whenComplete(() async {
          try {
            String fileUrl = await reference.getDownloadURL();
            print(fileUrl);
            userProfile.avatar = fileUrl;
            EditUser editUser = new EditUser(avatarLink: userProfile.avatar, email: userProfile.email, fullname: userProfile.fullname, nationLink: userProfile.nation);
            bool check = await _userRepository.editProfile(token, editUser);
            if(check == false){
              emit(EditProfileFailed());
            }else{
              emit(EditProfileSuccess());
            }
          } catch (onError) {
            emit(EditProfileFailed());
          }
        });
      }
    } on Exception{
      emit(EditProfileFailed());
    }
  }
}