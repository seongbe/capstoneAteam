// bottom_navigation_bar.dart

import 'package:capstone/controller/NavgationBarcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final HomeController controller = Get.find();

  CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        onTap: (index) {
          switch (index) {
            case 0:
              controller.goToHomePage();
              break;
            case 1:
              controller.goToChatPage();
              break;
            case 2:
              controller.goToMyPage();
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '거래채팅',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: '풀잎이',
          ),
        ],
      ),
    );
  }
}
