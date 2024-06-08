import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capstone/page/homepage/DetailItemPage.dart';

class BookListItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle1;
  final String subtitle2;
  final Map<String, dynamic> product;

  BookListItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    required this.product,
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
                  Row(
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
                      Text('3')
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
