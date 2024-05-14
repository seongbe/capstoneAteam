import 'package:capstone/component/chat.dart';
import 'package:capstone/component/chat2.dart';
import 'package:capstone/page/homepage/yaksookget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Chatingchang extends StatelessWidget {
  const Chatingchang({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          title: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {}, // 클릭 이벤트 추가
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: ShapeDecoration(
                          color: Color(0xCCF8FFF2),
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFFCFE4BC)),
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: Stack(
                        children: [
                          Image(
                              width: 35,
                              height: 45,
                              image: AssetImage('assets/images/book.png')),
                          Positioned(
                              left: 40,
                              top: 10,
                              child: Row(
                                children: [
                                  Text(
                                    '판매중',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xFF78BE39),
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '운영체제 공룡책',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              )),
                          Positioned(
                            left: 40,
                            top: 26,
                            child: Text(
                              '10,000',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(Yaksookget());
                    }, // 클릭 이벤트 추가
                    child: Container(
                      width: 82,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Color(0xFF78BE39),
                        border: Border.all(
                          color: Color(0xFF66AA28),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Image(
                              image: AssetImage('assets/icons/icon_clock.png')),
                          Text(
                            '약속잡기',
                            style: TextStyle(
                              fontFamily: 'mitmi',
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
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
                Divider(),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text('오전 09:43',
                            style: TextStyle(
                              color: Color(0xFF9F9F9F),
                              fontSize: 8,
                              fontFamily: 'Work Sans',
                              fontWeight: FontWeight.w500,
                              height: 0.34,
                              letterSpacing: -0.41,
                            )),
                      ],
                    ),
                    rightChatting(
                      text: '8000원 가능하실까요?',
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    leftChatting(
                      text: '9,000원으로 거래하시죠',
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text('오전 09:43  ',
                            style: TextStyle(
                              color: Color(0xFF9F9F9F),
                              fontSize: 8,
                              fontFamily: 'Work Sans',
                              fontWeight: FontWeight.w500,
                              height: 0.34,
                              letterSpacing: -0.41,
                            )),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text('오전 09:43',
                            style: TextStyle(
                              color: Color(0xFF9F9F9F),
                              fontSize: 8,
                              fontFamily: 'Work Sans',
                              fontWeight: FontWeight.w500,
                              height: 0.34,
                              letterSpacing: -0.41,
                            )),
                      ],
                    ),
                    rightChatting(
                      text: '8000원 가능하실까요?',
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
