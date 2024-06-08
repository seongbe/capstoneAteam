import 'package:capstone/page/homepage/DetailItemPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Chatlistitem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle1;
  final String subtitle2;
  final Map<String, dynamic>? product; // product 데이터 추가

  Chatlistitem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    this.product, // nullable product 데이터
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // 클릭되었을 때 다른 페이지로 이동하며 product 데이터를 전달
        Get.to(() => DetailItemPage(product: product));
      },
      child: Column(
        children: [
          Divider(),
          Row(
            children: [
              SizedBox(
                width: 100, // 이미지 너비 고정
                height: 100, // 이미지 높이 고정
                child: Image(image: NetworkImage(imagePath), fit: BoxFit.cover),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'skybori',
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    subtitle1,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'skybori',
                      color: Color(0xFF8c8c8c),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    subtitle2,
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'skybori',
                      color: Color(0xFF8c8c8c),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
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
