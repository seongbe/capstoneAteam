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
  bool isLoading = true; // 로딩 상태를 저장할 변수

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUserStatus();
    });
  }

  void checkUserStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      isLoggedIn = user != null; // 사용자가 로그인한 경우에만 true로 설정
      isLoading = false; // 로딩 완료
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    // Container의 너비와 높이를 동일하게 설정합니다.
    final containerSize = screenWidth;

    // 로딩 중일 때 로딩 화면을 보여줌
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

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
            child: StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection('Product').snapshots(),
  builder: (context, imageSnapshot) {
    if (imageSnapshot.hasError) {
      return Center(child: Text('Error: ${imageSnapshot.error}'));
    }
    if (imageSnapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }

    // Firestore에서 데이터를 가져와서 products 리스트를 생성합니다.
    final products = imageSnapshot.data!.docs.map((DocumentSnapshot document) {
      return document.data() as Map<String, dynamic>;
    }).toList();

                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                     final imageUrl = product['image_url'].isNotEmpty ? product['image_url'][0] : null;
    
                
                    return Column(
                      children: [
                        GestureDetector(
                          child: Chatlistitem(
                              imagePath: imageUrl, // 이미지 경로
                            title: product['title'], // 제목
                            subtitle1: product['description'], // 부제목1
                            subtitle2: "${product['price']} 원",
                            product: product, 
                              ),
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
