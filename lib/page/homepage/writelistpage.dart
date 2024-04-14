import 'package:capstone/component/Button.dart';
import 'package:capstone/page/homepage/rewritepage.dart';
import 'package:capstone/wiget/bottom.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';

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
        body: ListView(
          padding: EdgeInsets.fromLTRB(30.0, 20.0, 0.0, 0.0),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset('assets/images/book.jfif',
                        width: 66, height: 66, fit: BoxFit.contain),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 180,
                      height: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('운영체제 공룡책',
                              style: TextStyle(
                                fontFamily: 'skybori',
                                fontSize: 20,
                              )),
                          Text('3일전',
                              style: TextStyle(
                                fontFamily: 'skybori',
                                fontSize: 15,
                                color: Color.fromRGBO(140, 140, 140, 1),
                              )),
                        ],
                      ),
                    ),
                    GreenButton(
                      // 버튼 글씨 사이즈 수정해야함
                      text1: '수정하기',
                      width: 69,
                      height: 30,
                      onPressed: () {
                        Get.to(ReWritePage());
                      },
                    ),
                  ],
                ),
                Divider(
                  height: 50.0,
                  color: Color(0xffD0E4BC),
                  thickness: 1.0,
                  endIndent: 30.0,
                ),
                Row(
                  children: [
                    Image.asset('assets/images/book.jfif',
                        width: 66, height: 66, fit: BoxFit.contain),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 180,
                      height: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('운영체제 공룡책',
                              style: TextStyle(
                                fontFamily: 'skybori',
                                fontSize: 20,
                              )),
                          Text('3일전',
                              style: TextStyle(
                                fontFamily: 'skybori',
                                fontSize: 15,
                                color: Color.fromRGBO(140, 140, 140, 1),
                              )),
                        ],
                      ),
                    ),
                    GreenButton(
                      // 버튼 글씨 사이즈 수정해야함
                      text1: '수정하기',
                      width: 60,
                      height: 30,
                      onPressed: () {
                        Get.to(ReWritePage());
                      },
                    ),
                  ],
                ),
                Divider(
                  height: 50.0,
                  color: Color(0xffD0E4BC),
                  thickness: 1.0,
                  endIndent: 30.0,
                ),
              ],
            ),
          ],
        ));
  }
}
