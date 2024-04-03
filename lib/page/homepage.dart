import 'package:flutter/material.dart';

class Mainpage extends StatelessWidget {
  const Mainpage({super.key});

  @override
  Widget build(BuildContext context) {
    // 화면의 너비를 가져옵니다.
    final screenWidth = MediaQuery.of(context).size.width;
    // Container의 너비와 높이를 동일하게 설정합니다.
    final containerSize = screenWidth;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Container(
          width: containerSize,
          child: Image.asset(
            'assets/images/homepage.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
