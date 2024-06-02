import 'package:capstone/component/Button.dart';
import 'package:capstone/page/homepage/Writelistpage.dart';
import 'package:capstone/page/homepage/Setprofilepage.dart';
import 'package:capstone/page/homepage/qapage.dart';
import 'package:capstone/page/onboarding/LoginPage.dart';
import 'package:capstone/page/homepage/Interestlistpage.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Mypage extends StatelessWidget {
  const Mypage({Key? key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    // Container의 너비와 높이를 동일하게 설정합니다.
    final containerSize = screenWidth;
    return MaterialApp(
      title: 'Mypage',
      debugShowCheckedModeBanner: false,
      home: Pulip(),
    );
  }
}

class Pulip extends StatelessWidget {
  const Pulip({Key? key});

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData() async {
    // 현재 사용자의 UID 가져오기
    String? uid = FirebaseAuth.instance.currentUser!.uid;
    // Firestore에서 해당 사용자 정보 가져오기
    DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore.instance.collection('User').doc(uid).get();
    return userData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '마이페이지',
          style: TextStyle(
            fontFamily: 'skybori',
            fontSize: 30,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: getUserData(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else 
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // 사용자 정보 가져오기
              Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;
              String profileImageUrl = userData['profile_url']; // 사용자 프로필 이미지 URL
              String nickname = userData['nickname'];
              return ListView(
                padding: EdgeInsets.fromLTRB(30.0, 20.0, 0.0, 0.0),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(profileImageUrl), // 사용자 프로필 이미지 표시
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            nickname,
                            style: TextStyle(
                              fontFamily: 'skybori',
                              fontSize: 22,
                              letterSpacing: 2.0,
                            ),
                          ),
                          Spacer(),
                          GreenButton(
                            text1: '프로필수정',
                            width: 100,
                            height: 30,
                            textsize: 20,
                            onPressed: () {
                              Get.to(Setprofilepage());
                            },
                            letterspace: 5,
                          ),
                        ],
                      ),
                      Divider(
                        height: 50.0,
                        color: Color(0xffD0E4BC),
                        thickness: 1.0,
                        endIndent: 30.0,
                      ),
                      Text(
                        '나의 정보',
                        style: TextStyle(
                          fontFamily: 'skybori',
                          fontSize: 20,
                          letterSpacing: 2.0,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        children: [
                          Icon(Icons.account_balance),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '소속대학 : ',
                            style: TextStyle(
                              fontFamily: 'skybori',
                              fontSize: 17,
                              letterSpacing: 1.0,
                            ),
                          ),
                          Text(
                            ' xxxx대학',
                            style: TextStyle(
                              fontFamily: 'skybori',
                              fontSize: 17,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(Icons.menu_book),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '학과 : ',
                            style: TextStyle(
                              fontFamily: 'skybori',
                              fontSize: 17,
                              letterSpacing: 1.0,
                            ),
                          ),
                          Text(
                            ' xxxxxxx과',
                            style: TextStyle(
                              fontFamily: 'skybori',
                              fontSize: 17,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(Icons.assignment_ind_outlined),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '학번 : ',
                            style: TextStyle(
                              fontFamily: 'skybori',
                              fontSize: 17,
                              letterSpacing: 1.0,
                            ),
                          ),
                          Text(
                            ' 2xxxxxxxx',
                            style: TextStyle(
                              fontFamily: 'skybori',
                              fontSize: 17,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 50.0,
                        color: Color(0xffD0E4BC),
                        thickness: 1.0,
                        endIndent: 30.0,
                      ),
                      Text(
                        '나의 거래',
                        style: TextStyle(
                          fontFamily: 'skybori',
                          fontSize: 20,
                          letterSpacing: 2.0,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          //padding 0으로
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Get.to(Interestlistpage());
                        },
                        icon: Icon(
                          Icons.favorite_border_rounded,
                          color: Color.fromRGBO(29, 29, 29, 1),
                        ),
                        label: Text(
                          '관심목록',
                          style: TextStyle(
                            color: Color.fromRGBO(29, 29, 29, 1),
                            fontFamily: 'skybori',
                            fontSize: 17,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Get.to(Writelistpage());
                        },
                        icon: Icon(
                          Icons.list_alt_rounded,
                          color: Color.fromRGBO(29, 29, 29, 1),
                        ),
                        label: Text(
                          '내가 쓴 글',
                          style: TextStyle(
                            color: Color.fromRGBO(29, 29, 29, 1),
                            fontFamily: 'skybori',
                            fontSize: 17,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      Divider(
                        height: 50.0,
                        color: Color(0xffD0E4BC),
                        thickness: 1.0,
                        endIndent: 30.0,
                      ),
                      Text(
                        '문의 및 신고하기',
                        style: TextStyle(
                          fontFamily: 'skybori',
                          fontSize: 20,
                          letterSpacing: 2.0,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Get.to(QandApage());
                        },
                        icon: Icon(
                          Icons.warning_amber_rounded,
                          color: Color.fromRGBO(29, 29, 29, 1),
                        ),
                        label: Text(
                          '문의/신고글 작성',
                          style: TextStyle(
                            color: Color.fromRGBO(29, 29, 29, 1),
                            fontFamily: 'skybori',
                            fontSize: 17,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      Divider(
                        height: 50.0,
                        color: Color(0xffD0E4BC),
                        thickness: 1.0,
                        endIndent: 30.0,
                      ),
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Get.to(loginpage());
                        },
                        icon: Icon(
                          Icons.logout_rounded,
                          color: Color.fromRGBO(29, 29, 29, 1),
                        ),
                        label: Text(
                          '로그아웃',
                          style: TextStyle(
                            color: Color.fromRGBO(29, 29, 29, 1),
                            fontFamily: 'skybori',
                            fontSize: 17,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ],
                  )
                ]
              );
            }
        }
      ),
    );
  }
}
