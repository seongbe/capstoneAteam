import 'package:capstone/page/domainpage/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../component/button.dart';

class ContactDetailEnd extends StatelessWidget {
  final String contactId;

  const ContactDetailEnd({Key? key, required this.contactId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/icons/icon_back.png'),
          onPressed: () {
            Get.back();
          },
        ),
        title: Center(
          child: Text(
            '문의 / 신고 상세',
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
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('ContactTest')
            .doc(contactId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('해당 문서를 찾을 수 없습니다.'));
          }

          var data = {};
          if (snapshot.data != null) {
            data = snapshot.data!.data() as Map<String, dynamic>;
          }


          String inquiryName = data['inquiry_name'];
          String inquiryType = data['inquiry_type'];
          String id = data['user_id'];
          String detail = data['detail'];
          String date = data['date'];

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF8FFF2),
                      border: Border.all(width: 1, color: Color(0xffD0E4BC)),
                    ),
                    child: Text(
                      '문의 / 신고명 : $inquiryName',
                      style: TextStyle(fontSize: 20, fontFamily: 'skybori'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF8FFF2),
                      border: Border.all(width: 1, color: Color(0xffD0E4BC)),
                    ),
                    child: Text(
                      '문의 종류 : $inquiryType',
                      style: TextStyle(fontSize: 20, fontFamily: 'skybori'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF8FFF2),
                      border: Border.all(width: 1, color: Color(0xffD0E4BC)),
                    ),
                    child: Text(
                      '사용자 ID : $id',
                      style: TextStyle(fontSize: 20, fontFamily: 'skybori'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF8FFF2),
                      border: Border.all(width: 1, color: Color(0xffD0E4BC)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '내용',
                          style: TextStyle(fontSize: 20, fontFamily: 'skybori'),
                        ),
                        SizedBox(height: 5), // 내용과 : $detail 사이의 간격 조절
                        Text(
                          ': $detail',
                          style: TextStyle(fontSize: 20, fontFamily: 'skybori'),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF8FFF2),
                      border: Border.all(width: 1, color: Color(0xffD0E4BC)),
                    ),
                    child: Text(
                      '작성일시 : $date',
                      style: TextStyle(fontSize: 20, fontFamily: 'skybori'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF8FFF2),
                      border: Border.all(width: 1, color: Color(0xffD0E4BC)),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '처리상태 : ',
                          style: TextStyle(fontSize: 20, fontFamily: 'skybori'),
                        ),
                        Text(
                          '처리 완료',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'skybori',
                              color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 50.0,
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0xffD0E4BC), width: 1.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF8FFF2),
                      border: Border.all(width: 1, color: Color(0xffD0E4BC)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '답변',
                          style: TextStyle(fontSize: 20, fontFamily: 'skybori'),
                        ),
                        Text(
                          ': 해당 사용자를 정지 처리 하였으며, 곧 연락이 갈 것 입니다. 3-5일 소요예정.',
                          style: TextStyle(fontSize: 20, fontFamily: 'skybori'),
                        ),
                      ],
                    ),
                  ),
                ),
                GreenButton(
                  text1: '돌아가기',
                  width: 288,
                  height: 55,
                  onPressed: () {
                    Get.to(ContactPage());
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
