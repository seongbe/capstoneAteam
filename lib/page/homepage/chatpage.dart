import 'package:capstone/component/alertdialog_contact.dart';
import 'package:capstone/page/homepage/postwritepage.dart';
import 'package:capstone/page/onboarding/Certification.dart';
import 'package:capstone/wiget/BookListItem.dart';
import 'package:capstone/wiget/chatListitem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../onboarding/loginpage.dart';
import 'chatpage3.dart'; // 추가된 import
import 'homepage.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool isLoggedIn = false; // 로그인 상태를 저장할 변수
  bool isLoading = true;
  bool isStatusValid = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkUserStatus();
    });
  }

  void checkUserStatus() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Firestore에서 해당 uid 문서 가져오기
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('User')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        bool status = userDoc['status'];
        setState(() {
          isLoggedIn = user != null; // 사용자가 로그인한 경우에만 true로 설정
          isStatusValid = status; // status가 true일 때만 true로 설정
          isLoading = false; // 로딩 완료
        });
      } else {
        setState(() {
          isLoggedIn = false;
          isLoading = false; // 로딩 완료
        });
      }
    } else {
      setState(() {
        isLoggedIn = false;
        isLoading = false; // 로딩 완료
      });
    }
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

    // 사용자가 로그인했지만 계정이 정지된 경우 경고 메시지를 보여줌
    if (isLoggedIn && !isStatusValid) {
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
                  '계정이 정지상태 입니다.\n문의하기를 통해\n관리자에게 문의해주세요.',
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
                  Get.to(PostWritePage());
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
                  ' 문의하기  ',
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
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chatRooms2')
                  .where('users', arrayContains: FirebaseAuth.instance.currentUser?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final chatRooms = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: chatRooms.length,
                  itemBuilder: (context, index) {
                    final chatRoom = chatRooms[index];
                    if (!chatRoom.exists) {
                      return Container();
                    }

                    final productId = chatRoom['productId'];

                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance.collection('Product').doc(productId).get(),
                      builder: (context, productSnapshot) {
                        if (!productSnapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (!productSnapshot.data!.exists) {
                          // product가 없는 경우 빈 컨테이너 반환
                          return Container();
                        }

                        final productData = productSnapshot.data!.data() as Map<String, dynamic>?;

                        if (productData == null) {
                          // product 데이터가 null인 경우 빈 컨테이너 반환
                          return Container();
                        }

                        final imageUrl = productData['image_url'].isNotEmpty ? productData['image_url'][0] : null;
                        final description = productData['description'];
                        final shortDescription = description.length <= 20 ? description : '${description.substring(0, 20)} ... 더 보기';

                        return GestureDetector(
                          onTap: () {
                            Get.to(() => ChatPage3(chatRoomId: chatRoom.id, productOwnerId: productData['user_id'], productId: productId));
                          },
                          child: Chatlistitem(
                            imagePath: imageUrl, // 이미지 경로
                            title: productData['title'], // 제목
                            subtitle1: shortDescription, // 부제목1
                            subtitle2: "${productData['price']} 원",
                            product: productData,
                          ),
                        );
                      },
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
