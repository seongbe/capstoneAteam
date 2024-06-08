import 'dart:io';
import 'dart:math';

import 'package:capstone/component/alertdialog_login.dart';
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
            if (FirebaseAuth.instance.currentUser == null) {
              CustomDialogLogin.showAlert(context, '게시 기능은\n로그인 후 이용가능합니다.',
                  15.0, Color.fromRGBO(29, 29, 29, 1));
            } else {
              Get.to(PostWritePage());
            }
          },
          child: Icon(Icons.add),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Product').snapshots(),
            builder: (context, productSnapshot) {
              if (productSnapshot.hasError) {
                return Center(child: Text('Error: ${productSnapshot.error}'));
              }
              if (productSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              // Firestore에서 데이터를 가져와서 products 리스트를 생성합니다.
              final products = productSnapshot.data!.docs.map((DocumentSnapshot document) {
                return document.data() as Map<String, dynamic>;
              }).toList();

              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  final imageUrl = product['image_url'].isNotEmpty ? product['image_url'][0] : null;

                  return BookListItem(
                    imagePath: imageUrl,
                    title: product['title'],
                    subtitle1: product['description'],
                    subtitle2: product['price'],
                    product: product, // 전달할 데이터 추가
                  );
                },
              );
            }),
      ),
    );
  }
}
