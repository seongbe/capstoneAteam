import 'package:capstone/component/button.dart';
import 'package:capstone/page/homepage/homepage.dart';
import 'package:capstone/page/onboarding/Certification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';


class loginpage extends StatelessWidget {
  const loginpage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    // Container의 너비와 높이를 동일하게 설정합니다.
    final containerSize = screenWidth;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/domainPage_background.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(height: 110),
                  Image.asset(
                    'assets/images/skunivLogo.png',
                    width: 126.98,
                    height: 77.01,
                  ),
                  Text(
                    '풀잎장터',
                    style: TextStyle(
                      fontFamily: 'mitmi',
                      color: Color(0xFF7AAC4D),
                      fontSize: 55,
                      letterSpacing: 3.0,
                    ),
                  ),
                  SizedBox(
                    height: 120,
                  ),

                  const SizedBox(
                    width: 350,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: '아이디를 입력하세요.',
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
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  const SizedBox(
                    width: 350,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: '비밀번호를 입력하세요.',
                        labelStyle: TextStyle(color: Color(0xffC0C0C0),
                            fontFamily: 'mitmi'
                        ),
                        filled: true,
                        fillColor: Color(0xffF8FFF2),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                          BorderSide(width: 1, color: Color(0xffD0E4BC)),
                        ),
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      Icon(Icons.check_box),
                      SizedBox(
                        width: 5,
                      ),
                      Text('로그인 상태 유지',
                          style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SKYBORI',
                        fontSize: 18,)),
                    ]
                  ),

                  SizedBox(
                    height: 30,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('아이디 찾기',style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                        fontFamily: 'SKYBORI',
                        fontSize: 15,)),
                      Text(' / ',style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SKYBORI',
                        fontSize: 15,)),
                      Text('비밀번호 재설정',style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                        fontFamily: 'SKYBORI',
                        fontSize: 15,))
                    ],

                  ),

                  GreenButton(
                    text1: '로그인',
                    width: 288,
                    height: 55,
                    onPressed: () {
                      Get.to(HomePage());
                    },
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '아직 회원이 아니신가요?',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'SKYBORI',
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      TextButton(
                        onPressed: (){
                          Get.to(Certification());
                        },
                        child: Text('계정만들기',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xFF78BE39),
                            )
                        ),

                        style: TextButton.styleFrom(
                          foregroundColor: Color(0xFF78BE39),
                          textStyle: const TextStyle(
                            fontFamily: 'SKYBORI',
                            fontSize: 18,
                          ),


                        ),
                      ),
                    ],
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