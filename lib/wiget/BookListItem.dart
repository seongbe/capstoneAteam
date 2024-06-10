import 'package:capstone/component/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capstone/page/homepage/DetailItemPage.dart';

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
                    GreenButton(text1: '수정', width: 70, height:30, textsize: 15, onPressed: (){
                      Get.to(() => ReWritePage(product: product));
                    },),
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