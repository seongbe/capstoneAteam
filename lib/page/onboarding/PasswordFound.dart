import 'package:capstone/component/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:capstone/page/onboarding/PasswordCertification.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';

class PasswordFound extends StatelessWidget {
  const PasswordFound({super.key});

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
                    text1: '인증번호 발송',
                    width: 300,
                    height: 55,
                    onPressed: () {
                      Get.to(PasswordCertification());
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