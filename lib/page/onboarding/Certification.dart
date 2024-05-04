import 'package:capstone/component/button.dart';
import 'package:capstone/component/alterdilog2.dart';
import 'package:capstone/page/onboarding/createAcouunt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';

class Certification extends StatelessWidget {
  const Certification({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('회원가입'),
          titleTextStyle: const TextStyle(
              fontSize: 40, color: Colors.black, fontFamily: 'mitmi'),
          shape: const Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back(); // 뒤로 가기
            },
          ),
          actions: [
            Image.asset('assets/images/skon_fly.png'),
            SizedBox(width: 10),
          ],
        ),
        body: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 35,
                      ),
                      Text('학교 이메일',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SKYBORI',
                            fontSize: 20,
                          )),
                    ],
                  ),
                  const SizedBox(
                      width: 350,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Example@skuniv.ac.kr',
                          labelStyle: TextStyle(
                              color: Color(0xffC0C0C0), fontFamily: 'mitmi'),
                          filled: true,
                          fillColor: Color(0xffF8FFF2),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(width: 1, color: Color(0xffD0E4BC)),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  GreenButton(
                    text1: '인증메일받기',
                    width: 288,
                    height: 55,
                    onPressed: () {
                      CustomDialog2.showAlert(context, "입력한 학교 이메일로 인증번호가 발송되었습니다.", 20, Colors.black,(){});
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 35,
                      ),
                      Text('인증번호',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SKYBORI',
                            fontSize: 20,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Text('어떤 경우에도 타인에게 보여주지 마세요!',
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'SKYBORI',
                            fontSize: 15,
                          ))
                    ],
                  ),
                  const SizedBox(
                      width: 350,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: '인증번호를 입력하세요',
                          labelStyle: TextStyle(
                              color: Color(0xffC0C0C0), fontFamily: 'mitmi'),
                          filled: true,
                          fillColor: Color(0xffF8FFF2),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(width: 1, color: Color(0xffD0E4BC)),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  GreenButton(
                    text1: '인증번호확인',
                    width: 288,
                    height: 55,
                    onPressed: () {
                      CustomDialog2.showAlert(context, "입력한 인증번호가 틀렸습니다.\n 다시 입력해주세요.", 20, Colors.black,(){});
                    },
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  Container(
                    child: Text('이용약관 및 개인정보취급방침',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontFamily: 'SKYBORI',
                          fontSize: 15,
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GreenButton(
                    text1: '동의하고다음으로',
                    width: 300,
                    height: 55,
                    onPressed: () {
                      Get.to(CreatAccount());
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}