import 'package:capstone/wiget/bottom.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:capstone/wiget/WriteListItem.dart';

class Writelistpage extends StatelessWidget {
  const Writelistpage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    // Container의 너비와 높이를 동일하게 설정합니다.
    final containerSize = screenWidth;
    return MaterialApp(
      title: 'InterestListPage',
      debugShowCheckedModeBanner: false,
      home: Writelist(),
    );
  }
}

class Writelist extends StatelessWidget {
  const Writelist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '내가 쓴 글',
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
        body:  SafeArea(
            child: ListView(
              children: [
                WriteListItem(
                  imagePath: 'assets/images/book.png', // 이미지 경로
                  title: '운영체제 공룡책', // 제목
                  date: '3일전', //날짜
                ),
                WriteListItem(
                  imagePath: 'assets/images/book.png', // 이미지 경로
                  title: '운영체제 공룡책', // 제목
                  date: '5일전', //날짜
                ),
              ],
            ),
          ),
          bottomNavigationBar: CustomBottomNavigationBar()
        );
  }
}