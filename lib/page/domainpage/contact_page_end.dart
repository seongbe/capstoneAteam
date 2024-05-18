import 'package:capstone/component/contact_container_BLUE.dart';
import 'package:capstone/page/domainpage/contact_detail_end.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) {
                return ContactPageEnd();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ContactPageEnd extends StatelessWidget {
  const ContactPageEnd({Key? key}) : super(key: key);

  @override
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
                        Get.to(ContactDetailEnd());
                      },
                  child: ContactContainer_BLUE(
                    inquiryName: '이런 경우는 어떻게 해야하나요?',
                    inquiryType: '기타 문의',
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

