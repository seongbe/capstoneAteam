import 'package:capstone/page/homepage/postwritepage.dart';
import 'package:capstone/wiget/BookListItem.dart';
import 'package:capstone/wiget/mainpost.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/route_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MainPage extends StatelessWidget {
  String uid = FirebaseAuth.instance.currentUser?.uid ?? '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF78BE39),
          onPressed: () {
            Get.to(PostWritePage());
          },
          child: Icon(Icons.add),
        ),
        body: StreamBuilder(
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
                    Text(book['imagepath']),
                    Text(book['title']),
                    Text(book['subtitle1']),
                    Text(book['subtitle2']),
                    BookListItem(
                      imagePath: 'assets/images/book.png', // 이미지 경로
                      title: book['title'], // 제목
                      subtitle1: book['subtitle1'], // 부제목1
                      subtitle2: book['subtitle2'], // 부제목2
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
