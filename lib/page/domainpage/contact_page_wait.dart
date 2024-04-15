import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../component/contact_container_red.dart';
import 'contact_detail_wait.dart';

class ContactPageAllList extends StatelessWidget {
  const ContactPageAllList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Pages'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true, // ListView가 자신의 크기에 맞게 축소될 수 있도록 설정
              physics: NeverScrollableScrollPhysics(), // 스크롤을 막음
              itemCount: 6, // 생성할 ContactPageAll 위젯의 개수 (기존 5개 + 추가할 6개)
              itemBuilder: (context, index) {
                return ContactPageWait();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ContactPageWait extends StatelessWidget {
  const ContactPageWait({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Get.to(ContactDetailWait());
                    },
                  child: ContactContainer_RED(
                    inquiryName: '사기 당했습니다.',
                    inquiryType: '허위 매물',
                    id: '2024123123',
                  ),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}
