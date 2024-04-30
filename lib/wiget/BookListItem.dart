import 'package:capstone/page/homepage/DetailItemPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookListItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle1;
  final String subtitle2;

  BookListItem({
    required this.imagePath,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // 클릭되었을 때 다른 페이지로 이동
        Get.to(DetailItemPage());
      },
      child: Column(
        children: [
          Divider(),
          Row(
            children: [
              Image(image: AssetImage(imagePath)),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.start),
                  Text(subtitle1),
                  Text(subtitle2),
                  Row(
                    children: [
                      SizedBox(
                        width: 190,
                      ),
                      Icon(Icons.chat),
                      Icon(Icons.heart_broken)
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

class AnotherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Another Page'),
      ),
      body: Center(
        child: Text('This is another page.'),
      ),
    );
  }
}
