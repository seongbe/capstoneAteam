import 'package:capstone/page/onboarding/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:capstone/page/domainpage/user_manage_page.dart';
import 'package:capstone/page/domainpage/contact_page.dart';
import 'package:capstone/component/button.dart';

import '../onboarding/startPage.dart';

class DomainPage extends StatelessWidget {
  const DomainPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return MaterialApp(
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 70),
                  Image.asset(
                    'assets/images/skunivLogo.png',
                    width: 126.98,
                    height: 77.01,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '풀잎장터',
                    style: TextStyle(
                      fontFamily: 'mitmi',
                      color: Color(0xFF7AAC4D),
                      fontSize: 55,
                      letterSpacing: 3.0,
                    ),
                  ),
                  SizedBox(height: 150),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(UserManagePage());
                        },
                        child: Container(
                          width: 122.41,
                          height: 122.41,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFFF7FBF4),
                            border: Border.all(
                              color: Color(0xFF999999),
                              width: 1.4,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 6),
                              Image.asset(
                                'assets/icons/icon_users.png',
                                width: 68.15,
                                height: 68.15,
                                color: Color(0xFF5E5E5E),
                              ),
                              Text(
                                '사용자 관리',
                                style: TextStyle(
                                  fontFamily: 'mitmi',
                                  fontSize: 18,
                                  color: Color(0xFF5E5E5E),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(ContactPage());
                        },
                        child: Container(
                        width: 122.41,
                        height: 122.41,
                        margin: EdgeInsets.only(left: 48),
                        decoration: BoxDecoration(
                          color: Color(0xFFF7FBF4),
                          border: Border.all(
                            color: Color(0xFF999999),
                            width: 1.4,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 6),
                            Image.asset(
                              'assets/icons/icon_contact.png',
                              width: 68.15,
                              height: 68.15,
                              color: Color(0xFF5E5E5E),
                            ),
                            Text(
                              '문의 / 신고',
                              style: TextStyle(
                                fontFamily: 'mitmi',
                                fontSize: 18,
                                color: Color(0xFF5E5E5E),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: GreenButton(
                      text1: '로그아웃',
                      width: 288,
                      height: 55,
                      onPressed: () {
                        Get.to(loginpage());
                      },
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}