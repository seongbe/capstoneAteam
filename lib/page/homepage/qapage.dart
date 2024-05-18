import 'package:capstone/component/button.dart';
import 'package:capstone/page/homepage/mypage.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';

class QandApage extends StatefulWidget {
  const QandApage({super.key});

  @override
  State<QandApage> createState() => _QandApageState();
}

class _QandApageState extends State<QandApage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '문의/신고',
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
          Image.asset('assets/images/skon_fly.png'),
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
              Row(
                children: [
                  SizedBox(width: 20),
                  // 사진을 화면에 그려주기 위한 부분

                  IconButton(
                    style: IconButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 70,
                    ),
                    onPressed: () {
                      //사진 추가 버튼
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 30,
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
                  labelText: '제목을 입력하세요.',
                  helperText: "* 필수 입력값입니다.",
                  labelStyle:
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
                '문의.신고 유형',
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
                  labelText: 'ex)사기, 비속어 사용 등',
                  labelStyle:
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
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'skybori',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: '문의사항과 신고에 대해 자세히 설명해주세요.',
                  labelStyle:
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
                width: double.infinity,
                height: 70,
                child: GreenButton(
                  // 버튼 글씨 사이즈 수정해야함
                  text1: '신고하기',
                  width: 756,
                  height: 50,
                  onPressed: () {
                    //신고 완료 alert 띄우기
                    Get.to(Mypage());
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
