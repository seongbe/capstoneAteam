import 'package:capstone/component/button.dart';
import 'package:capstone/component/alerdialog.dart';
import 'package:capstone/page/onboarding/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:capstone/page/onboarding/PasswordCertification.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';

class PasswordReset extends StatelessWidget {
  const PasswordReset({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('비밀번호 재설정'),
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
                      Text('새 비밀번호',
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
                          labelText: '새 비밀번호를 입력하세요',
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
                      Text('새 비밀번호 확인',
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
                          labelText: '새 비밀번호를 한번 더 입력하세요',
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
                    text1: '비밀번호 재설정',
                    width: 300,
                    height: 55,
                    onPressed: () {
                      //CustomDialog.showAlert(context, "비밀번호 재설정이 완료되었습니다.\n 다시 로그인 해주세요.", 20, Colors.black);
                      Get.to(loginpage());
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