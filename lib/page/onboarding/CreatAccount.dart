import 'package:capstone/component/button.dart';
import 'package:capstone/component/alterdilog2.dart';
import 'package:capstone/page/onboarding/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('회원가입'),
          titleTextStyle: const TextStyle(fontSize: 40,
              color: Colors.black,
              fontFamily: 'mitmi'),
          shape: const Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          leading: Image.asset(
              'assets/icons/icon_back.png'
          ),
          actions: [
            Image.asset(
                'assets/images/skon_fly.png'
            ),
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
                      Text('아이디',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SKYBORI',
                            fontSize: 20,)),
                    ],
                  ),

                  const SizedBox(
                      width: 350,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: '아이디를 입력하세요',
                          labelStyle: TextStyle(color: Color(0xffC0C0C0),
                              fontFamily: 'mitmi'),
                          filled: true,
                          fillColor: Color(0xffF8FFF2),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(width: 1, color: Color(0xffD0E4BC)),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 35,
                      ),
                      Text('닉네임',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SKYBORI',
                            fontSize: 20,)),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                          width: 220,
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: '닉네임을 입력하세요',
                              labelStyle: TextStyle(color: Color(0xffC0C0C0),
                                  fontFamily: 'mitmi'),
                              filled: true,
                              fillColor: Color(0xffF8FFF2),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                BorderSide(width: 1, color: Color(0xffD0E4BC)),
                              ),
                            ),
                          )),
                      SizedBox(
                        child: GreenButton(
                          text1: '중복확인',
                          width: 80,
                          height: 40,
                          onPressed: () {
                            CustomDialog2.showAlert(context, "사용할 수 있는 닉네임 입니다.", 20, Colors.black,(){});
                            //CustomDialog2.showAlert(context, "이미 사용중인 닉네임 입니다.\n 새로운 닉네임을 입력하세요.", 20, Colors.black);
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Row(
                    children: [
                      SizedBox(
                        width: 35,
                      ),
                      Text('비밀번호',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SKYBORI',
                            fontSize: 20,)),
                    ],
                  ),

                  const SizedBox(
                      width: 350,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: '비밀번호를 입력하세요',
                          labelStyle: TextStyle(color: Color(0xffC0C0C0),
                              fontFamily: 'mitmi'),
                          filled: true,
                          fillColor: Color(0xffF8FFF2),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(width: 1, color: Color(0xffD0E4BC)),
                          ),
                        ),
                      )),

                  const SizedBox(
                    height: 20,
                  ),

                  Row(
                    children: [
                      SizedBox(
                        width: 35,
                      ),
                      Text('비밀번호 확인',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'SKYBORI',
                            fontSize: 20,)),
                    ],
                  ),

                  const SizedBox(
                      width: 350,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: '비밀번호를 한 번 더 입력하세요',
                          labelStyle: TextStyle(color: Color(0xffC0C0C0),
                              fontFamily: 'mitmi'),
                          filled: true,
                          fillColor: Color(0xffF8FFF2),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(width: 1, color: Color(0xffD0E4BC)),
                          ),
                        ),
                      )),

                  const SizedBox(
                    height: 50,
                  ),
                  GreenButton(
                    text1: '회원가입 완료',
                    width: 300,
                    height: 55,
                    onPressed: () {
                      CustomDialog2.showAlert(context, "회원가입이 완료되었습니다.\n 로그인 화면으로 이동합니다.", 20, Colors.black,(){});
                      //CustomDialog2.showAlert(context, "이미 사용중인 아이디 입니다.\n 새로운 아이디를 입력하세요.", 20, Colors.black);
                      //CustomDialog2.showAlert(context, "비밀번호가 일치하지 않습니다.\n 다시 입력해주세요.", 20, Colors.black);

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
