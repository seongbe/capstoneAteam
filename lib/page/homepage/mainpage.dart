import 'package:capstone/page/homepage/postwritepage.dart';
import 'package:capstone/wiget/BookListItem.dart';
import 'package:capstone/wiget/mainpost.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/route_manager.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //FAB을 전달하는 아규먼트
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xFF78BE39),
            onPressed: () {
              Get.to(PostWritePage());
            },
            child: Container(
              child: Icon(Icons.add),
            )),

        body: SafeArea(
          child: ListView(
            children: [
              BookListItem(
                imagePath: 'assets/images/book.png', // 이미지 경로
                title: '운영체제 공룡책', // 제목
                subtitle1: '소프트웨어학과 3일전', // 부제목1
                subtitle2: '10,000원', // 부제목2
              ),
              BookListItem(
                imagePath: 'assets/images/book.png', // 이미지 경로
                title: '운영체제 공룡책', // 제목
                subtitle1: '소프트웨어학과 3일전', // 부제목1
                subtitle2: '10,000원', // 부제목2
              ),
              BookListItem(
                imagePath: 'assets/images/book.png', // 이미지 경로
                title: '운영체제 공룡책', // 제목
                subtitle1: '소프트웨어학과 3일전', // 부제목1
                subtitle2: '10,000원', // 부제목2
              ),
              BookListItem(
                imagePath: 'assets/images/book.png', // 이미지 경로
                title: '운영체제 공룡책', // 제목
                subtitle1: '소프트웨어학과 3일전', // 부제목1
                subtitle2: '10,000원', // 부제목2
              ),
              BookListItem(
                imagePath: 'assets/images/book.png', // 이미지 경로
                title: '운영체제 공룡책', // 제목
                subtitle1: '소프트웨어학과 3일전', // 부제목1
                subtitle2: '10,000원', // 부제목2
              ),
              BookListItem(
                imagePath: 'assets/images/book.png', // 이미지 경로
                title: '운영체제 공룡책', // 제목
                subtitle1: '소프트웨어학과 3일전', // 부제목1
                subtitle2: '10,000원', // 부제목2
              ),
              BookListItem(
                imagePath: 'assets/images/book.png', // 이미지 경로
                title: '운영체제 공룡책', // 제목
                subtitle1: '소프트웨어학과 3일전', // 부제목1
                subtitle2: '10,000원', // 부제목2
              ),
              BookListItem(
                imagePath: 'assets/images/book.png', // 이미지 경로
                title: '운영체제 공룡책', // 제목
                subtitle1: '소프트웨어학과 3일전', // 부제목1
                subtitle2: '10,000원', // 부제목2
              ),
            ],
          ),
        ),
      ),
    );
  }
}
