import 'package:capstone/page/homepage/DetailItemPage.dart';
import 'package:capstone/page/homepage/chatingchang.dart';
import 'package:capstone/wiget/chatListitem.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    // Container의 너비와 높이를 동일하게 설정합니다.
    final containerSize = screenWidth;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '거래 채팅',
                    style: TextStyle(
                      fontFamily: 'skybori',
                      fontSize: 30,
                      letterSpacing: 2.0,
                    ),
                  ),
                  Image(
                    width: 76,
                    height: 70,
                    image: AssetImage(
                      'assets/images/skon_fly.png',
                    ),
                  ),
                ],
              ),
              Divider(
                height: 10.0,
                color: Color(0xffCCCCCC),
                thickness: 1.0,
                endIndent: 30.0,
              ),
            ],
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: ListView(
          children: [
            Column(
              children: [
                GestureDetector(
                  child: Chatlistitem(
                    imagePath: 'assets/images/book.png', // 이미지 경로
                    title: '운영체제 공룡책', // 제목
                    subtitle1: '소프트웨어학과 3일전', // 부제목1
                    subtitle2: '저는 화요일 5시 이후로 가능합니다',
                  ),
                ),
                GestureDetector(
                  child: Chatlistitem(
                    imagePath: 'assets/images/book.png', // 이미지 경로
                    title: '운영체제 공룡책', // 제목
                    subtitle1: '소프트웨어학과 3일전', // 부제목1
                    subtitle2: '저는 화요일 5시 이후로 가능합니다',
                  ),
                ),
                GestureDetector(
                  child: Chatlistitem(
                    imagePath: 'assets/images/book.png', // 이미지 경로
                    title: '운영체제 공룡책', // 제목
                    subtitle1: '소프트웨어학과 3일전', // 부제목1
                    subtitle2: '저는 화요일 5시 이후로 가능합니다',
                  ),
                ),
                GestureDetector(
                  child: Chatlistitem(
                    imagePath: 'assets/images/book.png', // 이미지 경로
                    title: '운영체제 공룡책', // 제목
                    subtitle1: '소프트웨어학과 3일전', // 부제목1
                    subtitle2: '저는 화요일 5시 이후로 가능합니다',
                  ),
                ),
                GestureDetector(
                  child: Chatlistitem(
                    imagePath: 'assets/images/book.png', // 이미지 경로
                    title: '운영체제 공룡책', // 제목
                    subtitle1: '소프트웨어학과 3일전', // 부제목1
                    subtitle2: '저는 화요일 5시 이후로 가능합니다',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
