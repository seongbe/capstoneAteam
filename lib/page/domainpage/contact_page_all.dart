import 'package:capstone/component/contact_container_BLUE.dart';
import 'package:flutter/material.dart';
import "package:capstone/page/domainpage/contact_detail_end.dart";
import "package:capstone/page/domainpage/contact_detail_wait.dart";
import '../../component/contact_container_red.dart';

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
                return ContactPageAll();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ContactPageAll extends StatelessWidget {
  const ContactPageAll({Key? key}) : super(key: key);

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
                if (index % 2 == 0) {
                  // index가 짝수일 때는 ContactContainer_RED 반환
                  return ContactContainer_RED(
                    inquiryName: '사기 당했습니다.',
                    inquiryType: '허위 매물',
                    id: '2024123123',
                  );
                } else {
                  // index가 홀수일 때는 ContactContainer_BLUE 반환
                  return ContactContainer_BLUE(
                    inquiryName: '이런 경우는 어떻게 해야하나요?',
                    inquiryType: '기타 문의',
                    id: '2024123123',
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
