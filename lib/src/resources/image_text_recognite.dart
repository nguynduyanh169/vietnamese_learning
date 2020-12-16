import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translator/translator.dart';

class DetailTranslateScreen extends StatefulWidget {
  @override
  _DetailTranslateScreenState createState() => _DetailTranslateScreenState();
}

class _DetailTranslateScreenState extends State<DetailTranslateScreen> {
  String selectedItem = '';
  File pickedImage;
  var imageFile;
  var result = '';
  bool isImageLoaded = false;
  List<Rect> rect = new List<Rect>();
  final translations = <String, String>{};

  getImageFromGallery() async {
    var tempStore = await ImagePicker().getImage(source: ImageSource.gallery);

    imageFile = await tempStore.readAsBytes();
    imageFile = await decodeImageFromList(imageFile);
    setState(() {
      pickedImage = File(tempStore.path);
      isImageLoaded = true;
      imageFile = imageFile;
    });
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

  String translator(String input){
    if(translations.containsKey(input)){
      return translations[input];
    }else{
      _translate(input);
      return input;
    }
  }

  Future<void> _translate(String input) async {
    GoogleTranslator translator = GoogleTranslator();

    Translation translation = await translator
        .translate(input, from: 'vi', to: 'en');
    setState(() => translations[input] = translation.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          RaisedButton(
            onPressed: getImageFromGallery,
            child: Icon(
              Icons.add_a_photo,
              color: Colors.white,
            ),
            color: Colors.blue,
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          // isImageLoaded
          //     ? Center(
          //         child: Container(
          //           child: FittedBox(
          //             child: SizedBox(
          //               width: imageFile.width.toDouble(),
          //               height: imageFile.height.toDouble(),
          //               child: CustomPaint(
          //                 painter:
          //                     FacePainter(rect: rect, imageFile: imageFile),
          //               ),
          //             ),
          //           ),
          //         ),
          //       )
          //     : Center(
          //         child: Container(
          //           height: 250.0,
          //           width: 250.0,
          //           decoration: BoxDecoration(
          //               image: DecorationImage(
          //                   image: FileImage(pickedImage), fit: BoxFit.cover)),
          //         ),
          //       ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(result),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          readTextFromImage();
        },
        child: Icon(Icons.check),
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
