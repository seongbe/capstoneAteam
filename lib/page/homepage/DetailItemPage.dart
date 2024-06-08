import 'package:capstone/page/homepage/chatingchang.dart';
import 'package:capstone/wiget/chat_button.dart';
import 'package:capstone/wiget/slideImage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';

import '../../component/alertdialog_login.dart';

class DetailItemPage extends StatefulWidget {
  final Map<String, dynamic>? product;

  DetailItemPage({this.product});

  @override
  State<DetailItemPage> createState() => _DetailItemPageState();
}

class _DetailItemPageState extends State<DetailItemPage> {
  bool isLiked = false;
  int likeCount = 0;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      likeCount = widget.product!['like_count'] ?? 0;
    }
  }

  void _toggleHeart() {
    setState(() {
      isLiked = !isLiked;
      likeCount = isLiked ? likeCount + 1 : likeCount - 1;
      _updateLikeCount();
    });
  }

  Future<void> _updateLikeCount() async {
    if (widget.product != null) {
      DocumentReference productRef = FirebaseFirestore.instance
          .collection('Product')
          .doc(widget.product!['post_id']);
      
      await productRef.update({'like_count': likeCount});
    }
  }

  String _formatDate(String dateTimeString) {
    final DateTime dateTime = DateTime.parse(dateTimeString);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final List<String> imgPaths = product != null && product['image_url'] != null
        ? List<String>.from(product['image_url'])
        : [];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('상세페이지'),
      ),
      body: product == null
          ? Center(child: Text('상품 정보가 없습니다.'))
          : SafeArea(
              child: ListView(
                children: [
                  ImageCarouselSlider(imgPaths: imgPaths),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Image(
                        width: 46,
                        height: 45,
                        image: AssetImage('assets/images/skon_fly.png'),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('풀잎이', style: TextStyle(fontSize: 16)),
                          Text('소프트웨어학과'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Text(
                            product['title'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'inter',
                              fontWeight: FontWeight.w700,
                              height: 0.09,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 20),
                      
                          Text(
                            _formatDate(product['created_at']),
                            style: TextStyle(
                              color: Color(0xFF8C8C8C),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0.12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        children: [
                          SizedBox(width: 20),
                          SizedBox(
                            child: Text(
                              product['description'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 20),
                          Text(
                            '관심  ',
                            style: TextStyle(
                              color: Color(0xFF8C8C8C),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0.12,
                            ),
                          ),
                          Text(
                            '좋아요수: $likeCount',
                            style: TextStyle(
                              color: Color(0xFF8C8C8C),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 0.12,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    width: 390,
                    height: 50,
                    child: Row(
                      children: [
                        SizedBox(width: 10),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: _toggleHeart,
                              child: Image(
                                width: 46,
                                height: 25,
                                image: AssetImage(isLiked
                                    ? 'assets/icons/img_2.png'
                                    : 'assets/icons/img_1.png'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['price'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0.09,
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              '가격 제안 불가',
                              style: TextStyle(
                                color: Color(0xFF8C8C8C),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 0.12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 140),
                        ChatButton(
                          width: 80,
                          height: 34,
                          text1: '채팅하기',
                          textsize: 14,
                          onPressed: () {
                            if (FirebaseAuth.instance.currentUser == null) {
                              CustomDialogLogin.showAlert(
                                context,
                                '채팅기능은\n로그인 후 이용가능합니다.',
                                15.0,
                                Color.fromRGBO(29, 29, 29, 1),
                              );
                            } else {
                              Get.to(Chatingchang());
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
