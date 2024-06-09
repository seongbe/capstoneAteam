import 'package:capstone/wiget/BookListItem.dart';
import 'package:capstone/wiget/bottom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:capstone/wiget/WriteListItem.dart';

class Writelistpage extends StatelessWidget {
  const Writelistpage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    // Container의 너비와 높이를 동일하게 설정합니다.
    final containerSize = screenWidth;
    return MaterialApp(
      title: 'WritetListPage',
      debugShowCheckedModeBanner: false,
      home: Writelist(),
    );
  }
}

class Writelist extends StatelessWidget {
  const Writelist({super.key});

  Future<String> getUserId() async {
    final User? user = FirebaseAuth.instance.currentUser;
    return user != null ? user.uid : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '내가 쓴 글',
          style: TextStyle(
            fontFamily: 'skybori',
            fontSize: 30,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          Image.asset('assets/images/skon_fly.png'),
          SizedBox(width: 20),
        ],
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.8,
          ),
        ),
      ),
      body: FutureBuilder<String>(
        future: getUserId(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('User not logged in.'));
          }
          final String userId = snapshot.data!;
          
          return StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Product').snapshots(),
            builder: (context, productSnapshot) {
              if (productSnapshot.hasError) {
                return Center(child: Text('Error: ${productSnapshot.error}'));
              }
              if (productSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              // Firestore에서 데이터를 가져와서 products 리스트를 생성합니다.
              final products = productSnapshot.data!.docs
                  .where((DocumentSnapshot document) => document['user_id'] == userId)
                  .map((DocumentSnapshot document) {
                return document.data() as Map<String, dynamic>;
              }).toList();

              if (products.isEmpty) {
                return Center(child: Text(
                  '작성한 상품이 없습니다.',
                  style: TextStyle(
                    fontFamily: 'skybori',
                    fontSize: 20,
                ),));
              }

              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  final imageUrl = product['image_url'].isNotEmpty ? product['image_url'][0] : null;

                  return BookListItem(
                    imagePath: imageUrl,
                    title: product['title'],
                    subtitle1: product['description'],
                    subtitle2: "${product['price']} 원",
                    product: product, // 전달할 데이터 추가
                    likecount: product['like_count'].toString(),
                    showButton: true,
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
