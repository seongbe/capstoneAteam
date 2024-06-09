import 'package:capstone/wiget/bottom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capstone/wiget/BookListItem.dart';

class Interestlistpage extends StatelessWidget {
  const Interestlistpage({Key? key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    // Container의 너비와 높이를 동일하게 설정합니다.
    final containerSize = screenWidth;

    final String userId = FirebaseAuth.instance.currentUser?.uid ?? ''; // userId 추가

    return MaterialApp(
      title: 'InterestListPage',
      debugShowCheckedModeBanner: false,
      home: InterList(userId: userId), // userId 전달
    );
  }
}

class InterList extends StatelessWidget {
  final String userId; // userId 추가
  const InterList({Key? key, required this.userId}) : super(key: key); // userId를 받는 생성자 추가
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '관심목록',
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
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('User').doc(userId).snapshots(),
        builder: (context, userSnapshot) {
          if (userSnapshot.hasError) {
            return Center(child: Text('Error: ${userSnapshot.error}'));
          }
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // 사용자 문서에서 관심 상품 목록 가져오기
          List<dynamic> interests = userSnapshot.data!.get('interests');

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('Product').snapshots(),
            builder: (context, productSnapshot) {
              if (productSnapshot.hasError) {
                return Center(child: Text('Error: ${productSnapshot.error}'));
              }
              if (productSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              // Firestore에서 데이터를 가져와서 products 리스트를 생성합니다.
              final products = productSnapshot.data!.docs.where((document) => interests.contains(document['post_id']))
                  .map((document) {
                return document.data() as Map<String, dynamic>;
              }).toList();

              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  final imageUrl = product['image_url'].isNotEmpty ? product['image_url'][0] : null;
                  final description = product['description'];
                  final shortDescription = description.length <= 20 ? description : '${description.substring(0, 20)} ... 더 보기';
                  return BookListItem(
                    imagePath: imageUrl,
                    title: product['title'],
                    subtitle1: shortDescription,
                    subtitle2: "${product['price']} 원",
                    product: product, // 전달할 데이터 추가
                    likecount: product['like_count'].toString(),
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
