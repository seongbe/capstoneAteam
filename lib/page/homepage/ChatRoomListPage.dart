import 'package:capstone/page/onboarding/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'chatpage3.dart'; // 추가된 import

class ChatRoomListPage extends StatefulWidget {
  @override
  _ChatRoomListPageState createState() => _ChatRoomListPageState();
}

class _ChatRoomListPageState extends State<ChatRoomListPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
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
                  .where('users', arrayContains: currentUser.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final chatRooms = snapshot.data!.docs;
                final uniqueProductChatRooms = <String, QueryDocumentSnapshot>{};

                for (var chatRoom in chatRooms) {
                  final chatRoomData = chatRoom.data() as Map<String, dynamic>?;
                  if (chatRoomData != null && chatRoomData.containsKey('productId')) {
                    uniqueProductChatRooms[chatRoomData['productId']] = chatRoom;
                  }
                }

                if (uniqueProductChatRooms.isEmpty) {
                  return Center(child: Text('참여한 채팅방이 없습니다.'));
                }

                return ListView.builder(
                  itemCount: uniqueProductChatRooms.length,
                  itemBuilder: (context, index) {
                    final chatRoom = uniqueProductChatRooms.values.elementAt(index);
                    final productId = chatRoom['productId'];

                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance.collection('Product').doc(productId).get(),
                      builder: (context, productSnapshot) {
                        if (!productSnapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }

                        final product = productSnapshot.data!.data() as Map<String, dynamic>;
                        final imageUrl = product['image_url'].isNotEmpty ? product['image_url'][0] : null;
                        final description = product['description'];
                        final shortDescription = description.length <= 20 ? description : '${description.substring(0, 20)} ... 더 보기';

                        return ListTile(
                          leading: imageUrl != null
                              ? Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover)
                              : Icon(Icons.image_not_supported),
                          title: Text(product['title']),
                          subtitle: Text(shortDescription),
                          onTap: () {
                                  Get.to(() => ChatPage3(chatRoomId: chatRoom.id, productOwnerId: product['user_id'], productId: productId));
                          },
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
