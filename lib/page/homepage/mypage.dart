import 'package:capstone/component/Button.dart';
import 'package:capstone/component/alterdilog3.dart';
import 'package:capstone/page/homepage/Writelistpage.dart';
import 'package:capstone/page/homepage/Setprofilepage.dart';
import 'package:capstone/page/homepage/qapage.dart';
import 'package:capstone/page/onboarding/StartPage.dart';
import 'package:capstone/page/onboarding/LoginPage.dart';
import 'package:capstone/page/onboarding/Accountdelete.dart';
import 'package:capstone/page/homepage/Interestlistpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileController extends GetxController {
  var profileImageUrl = ''.obs;

  void updateProfileImage(String imageUrl) {
    profileImageUrl.value = imageUrl;
  }
}

class Mypage extends StatelessWidget {
  const Mypage({Key? key});


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery
        .of(context)
        .size;
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
    DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
        .instance.collection('User').doc(uid).get();
    return userData;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    // 사용자가 로그인되어 있는지 확인
    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text(
                '마이페이지',
                style: TextStyle(
                  fontFamily: 'skybori',
                  fontSize: 30,
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Color(0xFFCFE4BC), // 배경색
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all( // 테두리 스타일
                  color: Color(0xFF65AA28), // 테두리 색상
                  width: 1.7, // 테두리 두께
                ), // 테두리 모양
                ),
                child: Text(
                  '마이페이지 기능은 \n로그인 후 이용 가능합니다.',
                  style: TextStyle(
                    color: Color.fromRGBO(29, 29, 29, 1),
                    fontFamily: 'mitmi',
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Get.offAll(loginpage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF78BE39),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(width: 1.50, color: Color(0xFF65AA28)),
                  ),
                ),
                child: Text(
                  ' 로그인 하기  ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontFamily: 'mitmi',
                    fontWeight: FontWeight.w400,
                    height: 0.03,
                    letterSpacing: 9.45,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }


    else {
      // 로그인된 경우 사용자 정보를 표시
      return Scaffold(
        appBar: AppBar(
          shape: const Border(bottom: BorderSide(color: Colors.grey, width: 1)),
          title: Column(
            children: [
              Text(
                '마이페이지',
                style: TextStyle(
                  fontFamily: 'skybori',
                  fontSize: 30,
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: FutureBuilder(
            future: getUserData(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                // 사용자 정보 가져오기
                Map<String, dynamic> userData = snapshot.data!.data() as Map<
                    String,
                    dynamic>;
                String profileImageUrl = userData['profile_url']; // 사용자 프로필 이미지 URL
                String nickname = userData['nickname'];
                String studentID = userData['StudentID'].toString();
                String department = userData['department'];
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
                                backgroundImage: profileImageUrl.isNotEmpty
                                    ? NetworkImage(profileImageUrl) as ImageProvider
                                    : AssetImage('assets/images/skon_fly.png') as ImageProvider,
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
                                department,
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
                                studentID,
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
                              Get.to(Writelistpage(), arguments: 'yourUserId');
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
                            onPressed: () async {
                              CustomDialog3.showConfirmationDialog(
                                context,
                                '비밀번호 재설정 메일을 전송하니\n'
                                    '메일함에서 절차를 진행해 주십시오.\n'
                                    '메일 전송후에는 로그아웃 됩니다.\n'
                                    '진행하시겠습니까?\n',
                                    () async {
                                      FirebaseAuth auth = FirebaseAuth.instance;
                                      await auth.sendPasswordResetEmail(email: user.email!);
                                      await auth.signOut();
                                      await Get.offAll(loginpage());
                                  return Future.value(); // 예시: 비동기적으로 작업을 수행하지 않는 경우에 사용
                                },
                              );
                            },
                            icon: Icon(
                              Icons.lock,
                              color: Color.fromRGBO(29, 29, 29, 1),
                            ),
                            label: Text(
                              '비밀번호 변경',
                              style: TextStyle(
                                color: Color.fromRGBO(29, 29, 29, 1),
                                fontFamily: 'skybori',
                                fontSize: 17,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextButton.icon(
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () async {
                              // 파이어베이스 통한 로그아웃
                              await FirebaseAuth.instance.signOut();
                              Get.offAll(StartPage());
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
                          SizedBox(
                            height: 10.0,
                          ),
                          TextButton.icon(
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () async {
                              //회원탈퇴 추가
                              Get.to(Accountdelete());
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Color.fromRGBO(29, 29, 29, 1),
                            ),
                            label: Text(
                              '회원탈퇴',
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
}
