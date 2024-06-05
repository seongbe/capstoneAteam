import 'package:capstone/component/button.dart';
import 'package:capstone/page/domainpage/contact_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:photo_view/photo_view.dart';

class ContactDetailWait extends StatefulWidget {
  final String contactId;

  const ContactDetailWait({Key? key, required this.contactId}) : super(key: key);

  @override
  _ContactDetailWaitState createState() => _ContactDetailWaitState();
}

class _ContactDetailWaitState extends State<ContactDetailWait> {
  final TextEditingController _answerController = TextEditingController();

  Future<Map<String, dynamic>?> getContactDetail() async {
    final doc = await FirebaseFirestore.instance
        .collection('ContactTest')
        .where('contact_id', isEqualTo: widget.contactId)
        .get();

    if (doc.docs.isNotEmpty) {
      return doc.docs.first.data();
    }
    return null;
  }

  void _submitAnswer() async {
    String answer = _answerController.text;

    if (answer.isNotEmpty) {
      final docRef = FirebaseFirestore.instance
          .collection('ContactTest')
          .doc(widget.contactId);


      try {
        await docRef.update({
          'answer': answer,
          'state': true,
        });

        print('Firestore document updated successfully.');

        CustomDialog.showAlert(
          context,
          "문의 / 신고글\n답변이 정상 등록되었습니다. ",
          27,
          Colors.black,
              () {
            Get.to(ContactPage());
          },
        );
      } catch (e) {
        print('Firestore update failed: $e');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('답변 등록 실패: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('답변을 입력해주세요')),
      );
    }
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
                  buildDetailContainer('내용', contact['detail'], imageUrls),
                  buildInfoContainer('작성일시', contact['date']),
                  buildStatusContainer('처리상태', contact['state'] ? '처리됨' : '미처리'),
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
                    child: TextField(
                      controller: _answerController,
                      decoration: InputDecoration(
                        labelText: '답변을 입력해주세요',
                        labelStyle: TextStyle(color: Color(0xffC0C0C0), fontFamily: 'skybori'),
                        filled: true,
                        fillColor: Color(0xffF8FFF2),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(width: 1, color: Color(0xffD0E4BC)),
                        ),
                      ),
                    ),
                  ),
                  GreenButton(
                    text1: '답변 남기기',
                    width: 288,
                    height: 55,
                    onPressed: _submitAnswer,
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

  Widget buildDetailContainer(String label, String detail, List<String> imageUrls) {
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
              label,
              style: TextStyle(fontSize: 20, fontFamily: 'skybori'),
            ),
            SizedBox(height: 5),
            Text(
              detail,
              style: TextStyle(fontSize: 20, fontFamily: 'skybori'),
            ),
            SizedBox(height: 10),
            if (imageUrls.isNotEmpty)
              ...imageUrls.map((url) =>
                  GestureDetector(
                    onTap: () => showDialog(
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
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Image.network(url),
                    ),
                  )).toList(),
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
              style: TextStyle(fontSize: 20, fontFamily: 'skybori', color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDialog {
  static void showAlert(
      BuildContext context,
      String message,
      double fontSize,
      Color textColor,
      VoidCallback moveToPage,
      ) {
    // 텍스트의 폭과 높이를 측정
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: message,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor,
        ),
      ),
      textDirection: ui.TextDirection.ltr,
      maxLines: 100, // 최대 줄 수
    );
    textPainter.layout(maxWidth: MediaQuery.of(context).size.width);

    // 팝업창의 크기를 텍스트의 크기에 맞게 조절
    double popupWidth = textPainter.width + 48; // 좌우 padding 고려
    double popupHeight = textPainter.height + 24; // 상하 padding 고려

    showDialog(
      context: context,
      barrierDismissible: true, // 팝업 창 외부 터치로 닫기 허용
      builder: (BuildContext context) {
        // 타이머를 사용하여 일정 시간 후에 자동으로 팝업 창을 닫음
        Timer(Duration(seconds: 2), () {
          Navigator.of(context).pop(); // 2초 후에 팝업 창 닫기
          moveToPage();
        });

        return AlertDialog(
          backgroundColor: Color(0xFFCFE4BC),
          content: SizedBox(
            width: popupWidth,
            height: popupHeight,
            child: Center(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: fontSize,
                  color: textColor,
                  fontFamily: 'mitmi',
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          actions: <Widget>[],
        );
      },
    );
  }
}
