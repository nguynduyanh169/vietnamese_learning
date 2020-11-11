import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vietnamese_learning/src/config/size_config.dart';

class EditPostScreen extends StatefulWidget{
  EditPostScreen({Key key}): super(key: key);

  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPostScreen>{
  TextEditingController txtTitle = new TextEditingController(text: 'những câu nói hay về cuộc sống');
  TextEditingController txtContent = new TextEditingController(text: "Thế giới bạn không bước vào được thì đừng cố chen vào, làm khó người khác, lỡ dở mình, hà tất chứ?"
      "\nĐôi khi, không cẩn thận biết một số chuyện, mới phát hiện ra rằng những điều bản thân để tâm lại nực cười đến thế.Đừng bao giờ thay đổi mình vì người khác. "
      "\nNếu họ không thể tiếp nhận một con người nhiều điểm xấu là bạn, thì cũng không xứng để có được một con người với nhiều điểm tốt là bạn."
      "\nĐôi khi sự đấu tranh luôn cần phải có trong cuộc sống. Nếu cuộc sống trôi qua thật suôn sẻ, chúng ta sẽ không hiểu được cuộc sống, không có được bản lĩnh, nghị lực như chúng ta cần phải có, cuộc sống thật công bằng, không phải vô cớ mà mọi điều xảy đến với ta.");
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(255, 239, 215, 1),
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical * 0.7,
            ),
            Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black26,
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 4,
                  ),
                  Text(
                    "Edit Post",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Helvetica',
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 56,
                  ),
                  InkWell(
                    child: Container(
                        height: SizeConfig.blockSizeVertical * 5,
                        width: SizeConfig.blockSizeHorizontal * 15,
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26.withOpacity(0.05),
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
                              color: Colors.black45,
                            ),
                          ),
                        )),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 2,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'haihl',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontFamily: 'Helvetica'),
                      ),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 1,
                      ),
                      Container(
                        width: 110,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                            width: 1.0,
                            color: Colors.grey,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '20/11/2020 at 12:00am',
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Helvetica',
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 95,
              height: SizeConfig.blockSizeVertical * 20,
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
              child: TextField(
                controller: txtTitle,
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Enter title here',
                  labelStyle: TextStyle(fontFamily: 'Helvetica', fontSize: 15),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 2,
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 95,
              height: SizeConfig.blockSizeVertical * 43,
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
              child: TextField(
                controller: txtContent,
                maxLines: 13,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  labelText: 'Enter content here',
                  labelStyle: TextStyle(fontFamily: 'Helvetica', fontSize: 15,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}