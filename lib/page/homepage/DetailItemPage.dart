import 'package:capstone/page/homepage/chatingchang.dart';
import 'package:capstone/wiget/chat_button.dart';
import 'package:capstone/wiget/slideImage.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class DetailItemPage extends StatelessWidget {
  final List<String> imgPaths = [
    'assets/images/book.png',
    'https://via.placeholder.com/600x400?text=Image+1',
    'https://via.placeholder.com/600x400?text=Image+2',
    'https://via.placeholder.com/600x400?text=Image+3',
    'https://via.placeholder.com/600x400?text=Image+4',
    'https://via.placeholder.com/600x400?text=Image+5',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          // 뒤로가기 버튼 추가
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // 뒤로가기 버튼 클릭 시 현재 페이지를 pop하여 이전 페이지로 이동
              Get.back();
            },
          ),
          title: Text('상세페이지'), // 앱 바 제목 설정
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Column(
                children: [
                  ImageCarouselSlider(imgPaths: imgPaths),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Image(
                        width: 46,
                        height: 45,
                        image: AssetImage(
                          'assets/images/skon_fly.png',
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('풀잎이',
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.start),
                          Text('소프트웨어학과'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '  운영체제 공룡책 팝니다',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'inter',
                      fontWeight: FontWeight.w700,
                      height: 0.09,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '디지털 기기 끝올 1일전',
                        style: TextStyle(
                          color: Color(0xFF8C8C8C),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0.12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    child: Text(
                      '  운영체제 공부하시는 분들\n  비싼 돈 내고 사지 마시고\n  이책 사가는 거 어때요~?\n  (feat.거의 새 거임 ㅎㅋ))',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '관심 15 조회 311 신고',
                        style: TextStyle(
                          color: Color(0xFF8C8C8C),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0.12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
              Divider(),
              SizedBox(
                width: 390,
                height: 50,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Image(
                          width: 46,
                          height: 25,
                          image: AssetImage(
                            'assets/icons/icon_heart_fill.png',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Column 내부의 자식 위젯들을 수직으로 중앙 정렬
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '10,000원',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0.09,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          '가격 제안 불가',
                          style: TextStyle(
                            color: Color(0xFF8C8C8C),
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0.12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 140,
                    ),
                    ChatButton(
                      width: 80,
                      height: 34,
                      text1: '채팅하기',
                      textsize: 14,
                      onPressed: () {
                        Get.to(Chatingchang());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
