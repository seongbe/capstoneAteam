import 'package:capstone/component/button.dart';
import 'package:capstone/component/alerdialog.dart';
import 'package:capstone/component/alterdilog2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';

class IDFound extends StatelessWidget {
  const IDFound({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('아이디 찾기'),
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
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 35,
                      ),
                      Text('생년월일',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SKYBORI',
                            fontSize: 20,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                      width: 350,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: '6자리 생년월일 ex)000120',
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

                  const SizedBox(
                    height: 40,
                  ),
                  GreenButton(
                    text1: '아이디 찾기',
                    width: 300,
                    height: 55,
                    onPressed: () {
                      CustomDialog2.showAlert(context, "해당 이메일로 가입된 정보가\n 존재하지 않습니다.", 20, Colors.black);
                      //CustomDialog2.showAlert(context, "생년월일을 올바르게 입력해주세요", 20, Colors.black);
                      //CustomDialog.showAlert(context, "이메일로 아이디를 발송했습니다.\n 다시 로그인 해주세요.", 20, Colors.black);
                      //Get.to(CreatAccount());
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