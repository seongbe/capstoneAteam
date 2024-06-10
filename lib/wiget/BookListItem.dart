import 'package:capstone/component/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capstone/page/homepage/DetailItemPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capstone/component/alterdilog3.dart';
import '../page/homepage/rewritepage.dart';

class BookListItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle1;
  final String subtitle2;
  final String likecount;
  final Map<String, dynamic> product;
  final bool showButton;

  BookListItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    required this.product,
    required this.likecount,
    this.showButton = false,
  });

// 해당 postId의 게시물을 Firestore에서 삭제하는 함수를 정의합니다.
  Future<void> deletePost(String postId) async {
    try {
      // Firestore에서 해당 postId의 게시물을 삭제합니다.
      await FirebaseFirestore.instance.collection('Product').doc(postId).delete();
      print('게시물이 성공적으로 삭제되었습니다.');
    } catch (error) {
      print('게시물 삭제 중 오류가 발생했습니다: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // 클릭되었을 때 다른 페이지로 이동
        Get.to(() => DetailItemPage(product: product));
      },
      child: Column(
        children: [
          Divider(),
          Row(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image(image: NetworkImage(imagePath), fit: BoxFit.cover),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 16)),
                  Text(subtitle1),
                  Text(subtitle2),
                  if(showButton)
                    Row(
                      children: [
                        GreenButton(
                          text1: '수정',
                          width: 70,
                          height: 30,
                          textsize: 15,
                          onPressed: () {
                            Get.to(() => ReWritePage(product: product));
                          },
                        ),
                        GreenButton(
                          text1: '삭제',
                          width: 70,
                          height: 30,
                          textsize: 15,
                          onPressed: () {
                            CustomDialog3.showConfirmationDialog(
                              context,
                              '삭제하시겠습니까?',
                                  () async {
                                    deletePost(product['post_id']);
                              },
                            );
                          },
                        ),

                      ],
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(width: 200),
                      Row(
                        children: [
                          Image(image: AssetImage('assets/icons/icon_chat.png')),
                          Text('3')
                        ],
                      ),
                      SizedBox(width: 5),
                      Image(
                        width: 20,
                        image: AssetImage('assets/icons/icon_heart.png')
                      ),
                      Text(likecount)
                    ],
                  )
                ],
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }
}