import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capstone/page/domainpage/contact_page_all.dart';
import 'package:capstone/page/domainpage/contact_page_wait.dart';
import 'package:capstone/page/domainpage/contact_page_end.dart';
import 'package:capstone/page/domainpage/Domainpage.dart';
import 'package:capstone/controller/navigationBarController_contact.dart';
import '../../wiget/bottom_contact.dart';


class ContactPage extends StatelessWidget {
  final ContactController controller = Get.put(ContactController());

  ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/icons/icon_back.png'),
          onPressed: () {
            Get.to(DomainPage());
          },
        ),
        title: Center(
          child: Text(
            '문의 / 신고       ',
            style: TextStyle(
              fontFamily: 'skybori',
              fontSize: 30,
              color: Color(0xFF464646),
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: Color(0xFFCCCCCC),
            thickness: 1.0,
          ),
        ),
      ),
      body: Obx(() {
        switch (controller.selectedIndex.value) {
          case 0:
            return ContactPageAll();
          case 1:
            return ContactPageWait();
          case 2:
            return ContactPageEnd();
          default:
            return ContactPageAll();
        }
      }),
      bottomNavigationBar: ContactCustomBottomNavigationBar(),
    );
  }
}
