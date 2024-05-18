import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capstone/page/domainpage/user_manage_page.dart';
import 'package:capstone/page/domainpage/contact_page.dart';
import 'package:capstone/component/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../onboarding/startPage.dart';

class DomainPage extends StatelessWidget {
  const DomainPage({Key? key}) : super(key: key);

  @override
<<<<<<< HEAD
  _DomainPageState createState() => _DomainPageState();
}

class _DomainPageState extends State<DomainPage> {
  List<String> likes = [];

  @override
  void initState() {
    super.initState();
    fetchLikes();
  }

  Future<void> fetchLikes() async {
    try {
      // Firestore에서 Product 컬렉션의 문서 가져오기
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('Product').get();

      // 각 문서의 Like 값을 리스트에 추가
      for (var doc in querySnapshot.docs) {
        likes.add(doc['Like'].toString());
      }

      // 상태 업데이트 요청
      setState(() {});
    } catch (e) {
      print('Error fetching likes: $e');
      // 에러 발생 시 '값이 안받아졌습니다' 텍스트 추가
      setState(() {
        likes.add('값이 안받아졌습니다');
      });
    }
  }

  @override
=======
>>>>>>> a726690c2e2d262accaa9590beb6c963c340c0ad
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
                        Get.to(StartPage());
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
