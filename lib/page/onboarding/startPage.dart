import 'package:capstone/component/button.dart';
import 'package:capstone/page/onboarding/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../homepage/homePage.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Scaffold(
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
                GestureDetector(
                  child: Column(
                    children: [
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
                    ],
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
                    Get.to(HomePage(0));
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
                    TextButton(
                      onPressed: () {
                        Get.to(loginpage());
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Color(0xFF78BE39),
                        textStyle: const TextStyle(
                          fontFamily: 'SKYBORI',
                          fontSize: 18,
                        ),
                      ),
                      child: Text(
                        '로그인',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFF78BE39),
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
    );
  }
}
