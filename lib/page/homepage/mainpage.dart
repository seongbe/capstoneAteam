import 'dart:io';
import 'dart:math';

import 'package:capstone/page/homepage/postwritepage.dart';
import 'package:capstone/wiget/BookListItem.dart';
import 'package:capstone/wiget/mainpost.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leadingWidth: 150,
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back(); // 뒤로 가기
                },
              ),
              SizedBox(
                width: 20,
              ),
              Text('최신순'),
              SizedBox(width: 5), // 아이콘과 텍스트 사이 여백 조절
              Image.asset('assets/icons/Expand Arrow.png') // 추가할 아이콘
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                // 맨 오른쪽에 위치한 첫 번째 아이콘의 클릭 이벤트 처리
              },
              icon: Icon(Icons.search), // 맨 오른쪽 첫 번째 아이콘
            ),
            IconButton(
              onPressed: () {
                // 맨 오른쪽에 위치한 두 번째 아이콘의 클릭 이벤트 처리
              },
              icon: Icon(Icons.notifications), // 맨 오른쪽 두 번째 아이콘
            ),
            IconButton(
              onPressed: () {
                // 맨 오른쪽에 위치한 세 번째 아이콘의 클릭 이벤트 처리
              },
              icon: Icon(Icons.settings), // 맨 오른쪽 세 번째 아이콘
            ),
          ],
        ),
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
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              final books = snapshot.data!.docs;

              return StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Images').snapshots(),
                builder: (context, imageSnapshot) {
                  if (imageSnapshot.hasError) {
                    return Center(child: Text('Error: ${imageSnapshot.error}'));
                  }
                  if (imageSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      return Column(
                        children: [
                          BookListItem(
                            imagePath: book['imagepath'], // 이미지 경로
                            title: book['title'], // 제목
                            subtitle1: book['subtitle1'], // 부제목1
                            subtitle2: book['subtitle2'], // 부제목2
                          ),
                          BookListItem(
                            imagePath: book['imagepath'], // 이미지 경로
                            title: book['title'], // 제목
                            subtitle1: book['subtitle1'], // 부제목1
                            subtitle2: book['subtitle2'], // 부제목2
                          ),
                          BookListItem(
                            imagePath: book['imagepath'], // 이미지 경로
                            title: book['title'], // 제목
                            subtitle1: book['subtitle1'], // 부제목1
                            subtitle2: book['subtitle2'], // 부제목2
                          ),
                          BookListItem(
                            imagePath: book['imagepath'], // 이미지 경로
                            title: book['title'], // 제목
                            subtitle1: book['subtitle1'], // 부제목1
                            subtitle2: book['subtitle2'], // 부제목2
                          ),
                          BookListItem(
                            imagePath: book['imagepath'], // 이미지 경로
                            title: book['title'], // 제목
                            subtitle1: book['subtitle1'], // 부제목1
                            subtitle2: book['subtitle2'], // 부제목2
                          ),
                          
                        ],
                      );
                    },
                  );
                },
              );
            }),
      ),
    );
  }
}
