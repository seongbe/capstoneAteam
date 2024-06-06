import 'package:capstone/component/alertdialog_login.dart';
import 'package:capstone/page/onboarding/Certification.dart';
import 'package:capstone/wiget/BookListItem.dart';
import 'package:capstone/wiget/chatListitem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../onboarding/loginpage.dart';
import 'homePage.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool isLoggedIn = false; // 로그인 상태를 저장할 변수

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUserStatus();
    });
  }

  void checkUserStatus() {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      isLoggedIn = user != null; // 사용자가 로그인한 경우에만 true로 설정
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    // Container의 너비와 높이를 동일하게 설정합니다.
    final containerSize = screenWidth;

    // 사용자가 로그인하지 않은 경우 "로그인이 필요합니다" 텍스트를 보여줌
    if (!isLoggedIn) {
      return Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '거래 채팅',
                    style: TextStyle(
                      fontFamily: 'skybori',
                      fontSize: 30,
                      letterSpacing: 2.0,
                    ),
                  ),
                  Image(
                    width: 76,
                    height: 70,
                    image: AssetImage(
                      'assets/images/skon_fly.png',
                    ),
                  ),
                ],
              ),
              Divider(
                height: 10.0,
                color: Color(0xffCCCCCC),
                thickness: 1.0,
                endIndent: 30.0,
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
                  '거래 채팅 기능은 \n로그인 후 이용 가능합니다.',
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

    // 사용자가 로그인한 경우 채팅 대화 목록을 보여줌
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '거래 채팅',
                  style: TextStyle(
                    fontFamily: 'skybori',
                    fontSize: 30,
                    letterSpacing: 2.0,
                  ),
                ),
                Image(
                  width: 76,
                  height: 70,
                  image: AssetImage(
                    'assets/images/skon_fly.png',
                  ),
                ),
              ],
            ),
            Divider(
              height: 10.0,
              color: Color(0xffCCCCCC),
              thickness: 1.0,
              endIndent: 30.0,
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
            // 이스트림 빌더가 데이터를 끌어오는 코드이다
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Book').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text('데이터 끌어오는거 실패해서 오류난거임'));
                }

                final books = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return Column(
                      children: [
                        GestureDetector(
                          child: Chatlistitem(
                              imagePath: book['imagepath'],
                              title: book['title'],
                              subtitle1: book['subtitle1'],
                              subtitle2: book['subtitle2']),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
