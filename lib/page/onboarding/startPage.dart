import 'package:capstone/component/button.dart';
import 'package:capstone/page/domainpage/domainpage.dart';
import 'package:capstone/page/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 화면의 너비를 가져옵니다.
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    // Container의 너비와 높이를 동일하게 설정합니다.
    final containerSize = screenWidth;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              width: screenWidth,
              height: screenHeight,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/homepage.png'),
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
                    height: 250,
                  ),
                  GreenButton(
                    text1: '시작하기',
                    width: 288,
                    height: 55,
                    onPressed: () {
                      Get.to(HomePage());
                    },
                  ),
                  GreenButton(
                    text1: '관리자페이지',
                    width: 288,
                    height: 55,
                    onPressed: () {
                      Get.to(domainPage());
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '이미 회원이신가요?',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'SKYBORI',
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        '로그인',
                        style: TextStyle(
                          color: Color(0xFF78BE39),
                          fontFamily: 'SKYBORI',
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFF78BE39),
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
