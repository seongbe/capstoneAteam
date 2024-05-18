// bottom_navigation_bar.dart

import 'package:capstone/controller/navigationBarController_contact.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactCustomBottomNavigationBar extends StatelessWidget {
  final ContactController controller = Get.find();

  ContactCustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        onTap: (index) {
          switch (index) {
            case 0:
              controller.goToAll();
              break;
            case 1:
              controller.goToWait();
              break;
            case 2:
              controller.goToEnd();
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/icon_contact_all.png'),
            label: '전체목록',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/icon_contact_wait.png'),
            label: '미처리',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/icon_contact_end.png'),
            label: '처리완료',
          ),
        ],
      ),
    );
  }
}
