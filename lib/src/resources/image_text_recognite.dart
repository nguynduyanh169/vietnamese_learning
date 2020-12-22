import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translator/translator.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';

class DetailTranslateScreen extends StatefulWidget {
  @override
  _DetailTranslateScreenState createState() => _DetailTranslateScreenState();
}

class _DetailTranslateScreenState extends State<DetailTranslateScreen> {
  String selectedItem = '';
  File pickedImage;
  var imageFile;
  var result = 'Translation';
  bool isImageLoaded = false;
  List<Rect> rect = new List<Rect>();
  final translations = <String, String>{};

  getImageFromGallery() async {
    var tempStore = await ImagePicker().getImage(source: ImageSource.camera);

    imageFile = await tempStore.readAsBytes();
    imageFile = await decodeImageFromList(imageFile);
    setState(() {
      pickedImage = File(tempStore.path);
      isImageLoaded = true;
      imageFile = imageFile;
    });
    readTextFromImage();
  }

  readTextFromImage() async {
    result = '';
    FirebaseVisionImage myImage = FirebaseVisionImage.fromFile(pickedImage);
    TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    VisionText readText = await textRecognizer.processImage(myImage);

    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          setState(() {
            result = result + ' ' + word.text;
          });
        }
      }
    }
  }

  String translator(String input) {
    if (translations.containsKey(input)) {
      return translations[input];
    } else {
      _translate(input);
      return input;
    }
  }

  Future<void> _translate(String input) async {
    GoogleTranslator translator = GoogleTranslator();

    Translation translation =
        await translator.translate(input, from: 'vi', to: 'en');
    setState(() => translations[input] = translation.text);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(255, 239, 215, 100),
        padding: EdgeInsets.only(
            left: SizeConfig.blockSizeHorizontal * 5,
            right: SizeConfig.blockSizeHorizontal * 5),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 2),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 22,
                  ),
                  Text(
                    'Translator',
                    style: TextStyle(
                        fontSize: 20, fontFamily: 'Helvetica'),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 19,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            Container(
              height: SizeConfig.blockSizeVertical * 30,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26.withOpacity(0.05),
                        offset: Offset(0.0, 6.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.10)
                  ]),
              child: isImageLoaded
                  ? Center(
                      child: Container(
                        decoration: ShapeDecoration(
                            image: DecorationImage(
                                image: FileImage(pickedImage),
                                fit: BoxFit.fitWidth),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusDirectional.circular(20))),
                        width: double.maxFinite,
                        height: SizeConfig.blockSizeVertical * 100,
                      ),
                    )
                  : Container(
                height: SizeConfig.blockSizeVertical * 30,
                width: SizeConfig.blockSizeHorizontal * 90,
                child: Center(
                  child: Text('<Your image>', style: TextStyle(fontFamily: 'Helvetica', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54), textAlign: TextAlign.center,),
                )

            ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 90,
              height: SizeConfig.blockSizeVertical * 30,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26.withOpacity(0.05),
                        offset: Offset(0.0, 6.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.10)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        translator(result),
                        style: TextStyle(fontFamily: 'Helvetica', fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: SizeConfig.blockSizeHorizontal * 33,
                  height: SizeConfig.blockSizeVertical * 10,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26.withOpacity(0.05),
                            offset: Offset(0.0, 6.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.10)
                      ]),
                  child: Row(
                    children: [
                      Image(
                          image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/master-vietnamese.appspot.com/o/country%2Fvietnam.png?alt=media&token=4d353d03-50f4-469c-aaa8-96afabb59fd9'),
                          width: SizeConfig.blockSizeVertical * 7,
                          height: SizeConfig.blockSizeHorizontal * 7,
                      ),
                      Text(
                        'Vietnamese',
                        style: TextStyle(fontFamily: 'Helvetica', fontSize: 13, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                FlatButton(
                  onPressed: getImageFromGallery,
                  color: Color.fromRGBO(255, 190, 51, 30),
                  textColor: Colors.white,
                  child: Icon(
                    CupertinoIcons.camera_fill,
                    size: 25,
                  ),
                  padding: EdgeInsets.all(20),
                  shape: CircleBorder(),
                ),
                Container(
                  width: SizeConfig.blockSizeHorizontal * 33,
                  height: SizeConfig.blockSizeVertical * 10,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26.withOpacity(0.05),
                            offset: Offset(0.0, 6.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.10)
                      ]),
                  child: Row(
                    children: [
                      Image(
                        image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/master-vietnamese.appspot.com/o/country%2Funited-states.png?alt=media&token=15d0039d-e9df-437f-aed7-6b03f2569172'),
                        width: SizeConfig.blockSizeVertical * 7,
                        height: SizeConfig.blockSizeHorizontal * 7,
                      ),
                      Text(
                        'English',
                        style: TextStyle(fontFamily: 'Helvetica', fontSize: 13, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FacePainter extends CustomPainter {
  List<Rect> rect;
  var imageFile;

  FacePainter({@required this.rect, @required this.imageFile});

  @override
  void paint(Canvas canvas, Size size) {
    if (imageFile != null) {
      canvas.drawImage(imageFile, Offset.zero, Paint());
    }

    for (Rect rectange in rect) {
      canvas.drawRect(
        rectange,
        Paint()
          ..color = Colors.teal
          ..strokeWidth = 6.0
          ..style = PaintingStyle.stroke,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    throw UnimplementedError();
  }
}
