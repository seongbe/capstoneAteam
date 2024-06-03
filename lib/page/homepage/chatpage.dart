import 'package:capstone/wiget/BookListItem.dart';
import 'package:capstone/wiget/chatListitem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    // Container의 너비와 높이를 동일하게 설정합니다.
    final containerSize = screenWidth;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
              //이스트림 빌더가 데이터를 끌어오는 코드이다
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('Book').snapshots(),
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
      ),
    );
  }
}
