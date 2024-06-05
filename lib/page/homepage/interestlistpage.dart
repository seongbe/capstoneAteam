import 'package:capstone/wiget/bottom.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:capstone/wiget/BookListItem.dart';

class Interestlistpage extends StatelessWidget {
  const Interestlistpage({super.key});

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
      home: InterList(),
    );
  }
}

class InterList extends StatelessWidget {
  const InterList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            '관심목록',
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
        body: SafeArea(
          child: ListView(
            children: [
              BookListItem(
                imagePath: 'https://lh4.googleusercontent.com/proxy/LyuGLKHAOWiVns2fni1cDeac-kwfzemwnP1zJXq2lB-CEwH8eXFe0wHbmWqyaq3Z0h6C7BLIl_5_pm6WswtyES-36rLj6zsimqzaD5tc7VtphA1a4YNzQyyYXqCTJQFy1sfbXK3-NjZIBtJViv44mBJG0xUiv4KPuWLs', // 이미지 경로
                title: '운영체제 공룡책', // 제목
                subtitle1: '소프트웨어학과 3일전', // 부제목1
                subtitle2: '10,000원', // 부제목2
              ),
              BookListItem(
                imagePath: 'https://lh4.googleusercontent.com/proxy/LyuGLKHAOWiVns2fni1cDeac-kwfzemwnP1zJXq2lB-CEwH8eXFe0wHbmWqyaq3Z0h6C7BLIl_5_pm6WswtyES-36rLj6zsimqzaD5tc7VtphA1a4YNzQyyYXqCTJQFy1sfbXK3-NjZIBtJViv44mBJG0xUiv4KPuWLs', // 이미지 경로
                title: '운영체제 공룡책', // 제목
                subtitle1: '소프트웨어학과 3일전', // 부제목1
                subtitle2: '10,000원', // 부제목2
              ),
              BookListItem(
                imagePath: 'https://lh4.googleusercontent.com/proxy/LyuGLKHAOWiVns2fni1cDeac-kwfzemwnP1zJXq2lB-CEwH8eXFe0wHbmWqyaq3Z0h6C7BLIl_5_pm6WswtyES-36rLj6zsimqzaD5tc7VtphA1a4YNzQyyYXqCTJQFy1sfbXK3-NjZIBtJViv44mBJG0xUiv4KPuWLs', // 이미지 경로
                title: '운영체제 공룡책', // 제목
                subtitle1: '소프트웨어학과 3일전', // 부제목1
                subtitle2: '10,000원', // 부제목2
              ),
            ],
            ),),
        bottomNavigationBar: CustomBottomNavigationBar());
  }
}
