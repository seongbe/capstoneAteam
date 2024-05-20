import 'package:capstone/component/ImagePickerScreen.dart';
import 'package:capstone/component/alerdialog.dart';
import 'package:capstone/component/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PostWritePage extends StatelessWidget {
  const PostWritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '게시물 작성',
          style: TextStyle(
            fontFamily: 'skybori',
            fontSize: 30,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          Text(
            '임시저장',
            style: TextStyle(
              color: Color(0xFF78BE39),
              fontSize: 20,
              fontFamily: 'skybori',
            ),
          ),
          SizedBox(width: 20),
        ],
        shape: Border(
            bottom: BorderSide(
          color: Colors.grey,
          width: 0.8,
        )),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImagePickerScreen(),
              Divider(
                color: Color(0xffD0E4BC),
                thickness: 1.0,
              ),
              Text(
                '제목',
                style: TextStyle(
                  fontFamily: 'skybori',
                  fontSize: 20,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: '제목을 입력하세요.',
                  hintStyle:
                      TextStyle(color: Color(0xffC0C0C0), fontFamily: 'mitmi'),
                  filled: true,
                  fillColor: Color(0xffF8FFF2),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Color(0xffD0E4BC)),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                '가격',
                style: TextStyle(
                  fontFamily: 'skybori',
                  fontSize: 20,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: '가격을 입력해 주세요',
                  hintStyle:
                      TextStyle(color: Color(0xffC0C0C0), fontFamily: 'mitmi'),
                  filled: true,
                  fillColor: Color(0xffF8FFF2),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Color(0xffD0E4BC)),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                '자세한 설명',
                style: TextStyle(
                  fontFamily: 'skybori',
                  fontSize: 20,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText:
                      '신뢰할 수 있는 거래를 위해 자세히 적어주세요. \n(판매금지 물품은 게시가 제한될 수 있어요)\n\n서경대 학생들의 안전한 중고거래 환경을 위해\n함께 노력해주세요)',
                  hintStyle:
                      TextStyle(color: Color(0xffC0C0C0), fontFamily: 'mitmi'),
                  filled: true,
                  fillColor: Color(0xffF8FFF2),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Color(0xffD0E4BC)),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 70,
                child: GreenButton(
                  // 버튼 글씨 사이즈 수정해야함
                  text1: '작성하기',
                  width: 756,
                  height: 50,
                  onPressed: () {
                    CustomDialog.showAlert(
                        context, "글이 정상적으로 등록되었습니다.", 14, Colors.black,(){});
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }

}
