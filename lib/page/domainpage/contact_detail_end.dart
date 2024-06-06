import 'package:capstone/component/button.dart';
import 'package:capstone/page/domainpage/contact_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:photo_view/photo_view.dart';

class ContactDetailEnd extends StatelessWidget {
  final String contactId;

  const ContactDetailEnd({Key? key, required this.contactId}) : super(key: key);

  Future<Map<String, dynamic>?> getContactDetail() async {
    final doc = await FirebaseFirestore.instance
        .collection('ContactTest')
        .where('contact_id', isEqualTo: contactId)
        .get();

    if (doc.docs.isNotEmpty) {
      return doc.docs.first.data();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset('assets/icons/icon_back.png'),
          onPressed: () {
            Get.to(ContactPage());
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
      body: FutureBuilder<Map<String, dynamic>?>(
        future: getContactDetail(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No contact found'));
          } else {
            final contact = snapshot.data!;
            final List<String> imageUrls = List<String>.from(contact['images_url'] ?? []);
            return SingleChildScrollView(
              child: Column(
                children: [
                  buildInfoContainer('문의 / 신고명', contact['inquiry_name']),
                  buildInfoContainer('문의 종류', contact['inquiry_type']),
                  buildInfoContainer('사용자 ID', contact['user_id']),
                  buildDetailContainer('내용', contact['detail'], imageUrls, context),
                  buildInfoContainer('작성일시', contact['date']),
                  buildStatusContainer('처리상태', contact['state'] ? '처리완료' : '미처리'),
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
                  buildInfoContainer('답변', contact['answer']),
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
          }
        },
      ),
    );
  }

  Widget buildInfoContainer(String label, String value) {
    return Padding(
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
          '$label : $value',
          style: TextStyle(fontSize: 20, fontFamily: 'skybori'),
        ),
      ),
    );
  }

  Widget buildDetailContainer(String label, String detail, List<String> imageUrls, BuildContext context) {
    return Padding(
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
              '$label : ',
              style: TextStyle(fontSize: 20, fontFamily: 'skybori'),
            ),
            SizedBox(height: 5),
            Text(
              detail,
              style: TextStyle(fontSize: 20, fontFamily: 'skybori'),
            ),
            SizedBox(height: 10),
            if (imageUrls.isNotEmpty)
              ...imageUrls.map((url) => Container(
                // imageUrls에 대한 Container 설정
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        insetPadding: EdgeInsets.zero,
                        child: Stack(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: PhotoView(
                                imageProvider: NetworkImage(url),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Image.network(url),
                  ),
                ),
              )),
          ],
        ),
      ),
    );
  }

  Widget buildStatusContainer(String label, String status) {
    return Padding(
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
              '$label : ',
              style: TextStyle(fontSize: 20, fontFamily: 'skybori'),
            ),
            Text(
              status,
              style: TextStyle(fontSize: 20, fontFamily: 'skybori', color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
