import 'package:capstone/controller/NavgationBarcontroller.dart';
import 'package:capstone/page/homepage/chatpage.dart';
import 'package:capstone/page/homepage/mainpage.dart';
import 'package:capstone/page/homepage/mypage.dart';
import 'package:capstone/wiget/bottom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  HomePage(int i, {super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

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