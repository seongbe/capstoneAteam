import 'package:capstone/component/button.dart';
import 'package:capstone/page/homepage/DetailItemPage.dart';
import 'package:capstone/page/homepage/rewritepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WriteListItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String date;
   final Map<String, dynamic>? product; // product 데이터 추가

  const WriteListItem({
    required this.imagePath,
    required this.title,
    required this.date,
        this.product, // nullable product 데이터
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //클릭 되었을 때 쓴 글 보러가기
        Get.to(DetailItemPage());
      },
      child: Column(
        children: [
          Divider(
            color: Color(0xffD0E4BC),
            thickness: 1.0,
          ),
          Row(
            children: [
              Image.network(
                imagePath,
                width: 100, // 이미지의 너비
                height: 100, // 이미지의 높이
                fit: BoxFit.cover, // 이미지 맞추기 방식
              ),
              //Image(image: AssetImage(imagePath)),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'skybori',
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      fontFamily: 'skybori',
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(
                width: 60,
              ),
              GreenButton(
                // 버튼 글씨 사이즈 수정해야함
                text1: '수정',
                width: 69,
                height: 30,
                onPressed: () {
                  //Get.to(ReWritePage());
                },
                textsize: 20,
              ),
            ],
          ),
          Divider(
            color: Color(0xffD0E4BC),
            thickness: 1.0,
          ),
        ],
      ),
    );
  }
}