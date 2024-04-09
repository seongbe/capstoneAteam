import 'package:capstone/controller/NavgationBarcontroller.dart';
import 'package:capstone/page/homepage/chatpage.dart';
import 'package:capstone/page/homepage/mainpage.dart';
import 'package:capstone/page/homepage/mypage.dart';
import 'package:capstone/wiget/bottom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    // Container의 너비와 높이를 동일하게 설정합니다.
    final containerSize = screenWidth;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leadingWidth: 150,
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back(); // 뒤로 가기
                },
              ),

              SizedBox(
                width: 20,
              ),
              Text('최신순'),
              SizedBox(width: 5), // 아이콘과 텍스트 사이 여백 조절
              Image.asset('assets/icons/Expand Arrow.png') // 추가할 아이콘
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                // 맨 오른쪽에 위치한 첫 번째 아이콘의 클릭 이벤트 처리
              },
              icon: Icon(Icons.search), // 맨 오른쪽 첫 번째 아이콘
            ),
            IconButton(
              onPressed: () {
                // 맨 오른쪽에 위치한 두 번째 아이콘의 클릭 이벤트 처리
              },
              icon: Icon(Icons.notifications), // 맨 오른쪽 두 번째 아이콘
            ),
            IconButton(
              onPressed: () {
                // 맨 오른쪽에 위치한 세 번째 아이콘의 클릭 이벤트 처리
              },
              icon: Icon(Icons.settings), // 맨 오른쪽 세 번째 아이콘
            ),
          ],
        ),
        body: Obx(() {
          switch (controller.selectedIndex.value) {
            case 0:
              return MainPage();
            case 1:
              return ChatPage();
            case 2:
              return Mypage();
            default:
              return MainPage();
          }
        }),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}
