import 'dart:io';
import 'dart:math';

import 'package:capstone/component/alertdialog_contact.dart';
import 'package:capstone/component/alertdialog_login.dart';
import 'package:capstone/page/homepage/mypage.dart';
import 'package:capstone/page/homepage/postwritepage.dart';
import 'package:capstone/page/homepage/qapage.dart';
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
  String sortOrder = '최신순';
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leadingWidth: 200,
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back(); // 뒤로 가기
                },
              ),
              SizedBox(width: 10),
              DropdownButton<String>(
                value: sortOrder,
                onChanged: (String? newValue) {
                  setState(() {
                    sortOrder = newValue!;
                  });
                },
                items: <String>['최신순', '인기순']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          title: TextField(
    controller: _searchController,
    decoration: InputDecoration(
      hintText: '검색...',
      border: InputBorder.none,
    ),
    onChanged: _updateSearchQuery,
  ),
          actions: [
            IconButton(
              onPressed: () {
               setState(() {
          _searchQuery = _searchController.text;
        });
              },  
              icon: Icon(Icons.search), // 맨 오른쪽 첫 번째 아이콘
            ),
             
            IconButton(
              onPressed: () {
               Get.to(Mypage());
              },
              icon: Icon(Icons.settings), // 맨 오른쪽 세 번째 아이콘
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF78BE39),
          onPressed: () async {
            if (FirebaseAuth.instance.currentUser == null) {
              CustomDialogLogin.showAlert(context, '게시 기능은\n로그인 후 이용가능합니다.',
                  15.0, Color.fromRGBO(29, 29, 29, 1));
            } else {
              String uid = FirebaseAuth.instance.currentUser!.uid;

              DocumentSnapshot userDoc = await FirebaseFirestore.instance
                  .collection('User')
                  .doc(uid)
                  .get();

              bool status = userDoc['status'];

              if (status == false) {
                CustomDialogContact.showAlert(context, '계정이 정지상태 입니다.\n문의하기를 통해\n관리자에게 문의해주세요.',
                    15.0, Color.fromRGBO(29, 29, 29, 1));
              } else {
                Get.to(PostWritePage());
              }
            }
          },
          child: Icon(Icons.add),
        ),
        body:StreamBuilder(
  stream: (_searchQuery.isEmpty)
      ? (sortOrder == '최신순'
          ? FirebaseFirestore.instance
              .collection('Product')
              .orderBy('created_at', descending: true)
              .snapshots()
          : FirebaseFirestore.instance
              .collection('Product')
              .orderBy('like_count', descending: true)
              .snapshots())
      : FirebaseFirestore.instance
          .collection('Product')
          .where('title', isGreaterThanOrEqualTo: _searchQuery)
          .where('title', isLessThanOrEqualTo: _searchQuery + '\uf8ff')
          .snapshots(),
  builder: (context, productSnapshot) {
    if (productSnapshot.hasError) {
      return Center(child: Text('Error: ${productSnapshot.error}'));
    }
    if (productSnapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }

    final products = productSnapshot.data!.docs.map((DocumentSnapshot document) {
      return document.data() as Map<String, dynamic>;
    }).toList();

    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final imageUrl = product['image_url'].isNotEmpty
            ? product['image_url'][0]
            : null;
        final description = product['description'];
        final shortDescription = description.length <= 20
            ? description
            : '${description.substring(0, 20)} ... 더 보기';

        return BookListItem(
          imagePath: imageUrl,
          title: product['title'],
          subtitle1: shortDescription,
          subtitle2: "${product['price']} 원",
          product: product,
          likecount: product['like_count'].toString(),
        );
      },
    );
  },
),

      ),
    );
  }
}
