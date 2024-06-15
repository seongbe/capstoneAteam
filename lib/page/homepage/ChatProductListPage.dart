import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'chatpage3.dart'; // ChatPage3 import

class ChatProductListPage extends StatelessWidget {
  const ChatProductListPage({Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> _getChatProducts() async {
    final _auth = FirebaseAuth.instance;
    final _firestore = FirebaseFirestore.instance;

    final chatRoomsSnapshot = await _firestore.collection('chatRooms2')
        .where('users', arrayContains: _auth.currentUser?.uid)
        .get();

    final products = <Map<String, dynamic>>[];

    for (var chatRoom in chatRoomsSnapshot.docs) {
      final chatRoomData = chatRoom.data();
      if (chatRoomData.containsKey('productId')) {
        final productId = chatRoomData['productId'];
        final productSnapshot = await _firestore.collection('Product').doc(productId).get();
        if (productSnapshot.exists) {
          final productData = productSnapshot.data()!;
          productData['chatRoomId'] = chatRoom.id; // Add chatRoomId to product data
          products.add(productData);
        }
      }
    }

    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '채팅한 상품 목록',
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
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getChatProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('채팅한 상품이 없습니다.'));
          }

          final products = snapshot.data!;

          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final imageUrl = product['image_url'].isNotEmpty ? product['image_url'][0] : null;
              final description = product['description'];
              final shortDescription = description.length <= 20 ? description : '${description.substring(0, 20)} ... 더 보기';

              return GestureDetector(
                onTap: () {
                  Get.to(() => ChatPage3(
                        chatRoomId: product['chatRoomId'],
                        productId: product['post_id'],
                        productOwnerId: product['user_id'],
                      ));
                },
                child: ListTile(
                  leading: imageUrl != null ? Image.network(imageUrl) : null,
                  title: Text(product['title']),
                  subtitle: Text(shortDescription),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
