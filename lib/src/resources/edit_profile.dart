import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';
import 'package:vietnamese_learning/src/cubit/edit_profile_cubit.dart';
import 'package:vietnamese_learning/src/data/user_repository.dart';
import 'package:vietnamese_learning/src/models/nation.dart';
import 'package:vietnamese_learning/src/models/user_profile.dart';
import 'package:vietnamese_learning/src/states/edit_profile_state.dart';
import 'package:vietnamese_learning/src/widgets/choose_nation.dart';
import 'package:vietnamese_learning/src/widgets/progress_dialog.dart';

import 'home_page.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key key}) : super(key: key);

  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  UserProfile userProfile;
  TextEditingController txtUsername, txtFullname, txtEmail, txtNation;
  String imageUrl;
  List<Nation> nations;
  String userNationLink;

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget _userAvatar(BuildContext context, String imageUrl) {
    if (imageUrl == null) {
      return CircleAvatar(
        radius: 45,
        backgroundImage: AssetImage('assets/images/profile.png'),
      );
    }
    if (imageUrl != null) {
      return CircleAvatar(
        radius: 45,
        backgroundImage: NetworkImage(imageUrl),
      );
    }
  }

  void submitProfile(BuildContext context){
    userProfile.fullname = txtFullname.text;
    BlocProvider.of<EditProfileCubit>(context).editProfile(userProfile, _image);
  }

  Widget _chooseNation() {
    return ChooseNation(
      nations: nations,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => EditProfileCubit(UserRepository())..LoadEditProfile(),
      child: BlocConsumer<EditProfileCubit, EditProfileState>(
        listener: (context, state) {
          if (state is LoadedEditProfile) {
            userProfile = state.userProfile;
            imageUrl = userProfile.avatar;
            nations = state.nations;
            userNationLink = userProfile.nation;
            txtNation = new TextEditingController(text: ' ');
            for (Nation nation in nations){
              if(nation.image == userNationLink){
                txtNation = new TextEditingController(text: nation.nation);
              }
            }
            txtUsername = new TextEditingController(text: userProfile.username);
            txtFullname = new TextEditingController(text: userProfile.fullname);
            txtEmail = new TextEditingController(text: userProfile.email);
          }else if(state is EditingProfile){
            CustomProgressDialog.progressDialog(context);
          }else if(state is EditProfileSuccess){
            Navigator.pop(context);
            Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomePage()),
                    (route) => false);
          }
        },
        builder: (context, state) {
          if (state is LoadingEditProfile) {
            print('loading');
            return _loadingProfile(context);
          } else {
            return Scaffold(
              backgroundColor: Color.fromRGBO(255, 239, 215, 1),
              body: Container(
                color: Color.fromRGBO(255, 239, 215, 100),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical * 2),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 24,
                            ),
                            Text(
                              'Edit profile',
                              style: TextStyle(
                                  fontSize: 20, fontFamily: 'Helvetica'),
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal * 18,
                            ),
                            InkWell(
                              child: Container(
                                  height: SizeConfig.blockSizeVertical * 5,
                                  width: SizeConfig.blockSizeHorizontal * 15,
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(10.0),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                            Colors.black26.withOpacity(0.05),
                                            offset: Offset(0.0, 6.0),
                                            blurRadius: 10.0,
                                            spreadRadius: 0.10)
                                      ]),
                                  child: Center(
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Helvetica',
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                              onTap: () {
                                submitProfile(context);
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2,
                      ),
                      Container(
                        child: Stack(
                          children: <Widget>[
                            _image == null
                                ? _userAvatar(context, imageUrl)
                                : CircleAvatar(
                              radius: 45,
                              backgroundImage: FileImage(_image),
                            ),
                            Positioned(
                                left: SizeConfig.blockSizeHorizontal * 17,
                                bottom: SizeConfig.blockSizeVertical * 8,
                                child: InkWell(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: Container(
                                    width: SizeConfig.blockSizeHorizontal * 6,
                                    height: SizeConfig.blockSizeVertical * 7,
                                    child: Icon(
                                      CupertinoIcons.pen,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.redAccent),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 3,
                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 85,
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          "Username",
                          style: TextStyle(fontFamily: 'Helvetica'),
                        ),
                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 85,
                        child: TextFormField(
                          readOnly: true,
                          controller: txtUsername,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            labelText: 'Enter your Username',
                            labelStyle:
                            TextStyle(fontFamily: 'Helvetica', fontSize: 15),
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 3.0),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 85,
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          "Name",
                          style: TextStyle(fontFamily: 'Helvetica'),
                        ),
                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 85,
                        child: TextFormField(
                          controller: txtFullname,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              labelText: 'Enter your name',
                              labelStyle: TextStyle(
                                  fontFamily: 'Helvetica', fontSize: 15),
                              prefixIcon: Icon(CupertinoIcons.person_solid)),
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 3.0),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 85,
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          "Email",
                          style: TextStyle(fontFamily: 'Helvetica'),
                        ),
                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 85,
                        child: TextFormField(
                          controller: txtEmail,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            labelText: 'Enter your Email',
                            labelStyle:
                            TextStyle(fontFamily: 'Helvetica', fontSize: 15),
                            prefixIcon: Icon(CupertinoIcons.mail_solid),
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical * 3.0),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 85,
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          "Nation",
                          style: TextStyle(fontFamily: 'Helvetica'),
                        ),
                      ),
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 85,
                        child: TextFormField(
                          onTap: (){
                            showCupertinoModalBottomSheet(
                              expand: false,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context, scrollController) =>
                                  _chooseNation(),
                            ).then((value){
                              Nation nation = value;
                              txtNation.text = nation.nation;
                              userProfile.nation = nation.image;
                            });
                          },
                          readOnly: true,
                          controller: txtNation,
                          //obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              labelText: 'Choose your Nation',
                              labelStyle: TextStyle(
                                  fontFamily: 'Helvetica', fontSize: 15),
                              prefixIcon: Icon(CupertinoIcons.globe)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _loadingProfile(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 239, 215, 100),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CupertinoActivityIndicator(
              radius: 20,
            ),
          ],
        ),
      ),
    );
  }
}
