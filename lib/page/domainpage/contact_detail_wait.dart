import 'package:capstone/component/button.dart';
import 'package:capstone/page/domainpage/contact_page.dart';
import 'package:capstone/page/domainpage/contact_page_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:ui' as ui;

class ContactDetailWait extends StatelessWidget {
  const ContactDetailWait({Key? key}) : super(key: key);

  get inquiryName => '사기 당했습니다 ㅠㅠ';
  get id => '2024123123';
  get inquiryType => '사기';
  get detail =>'판매자가 책을 1권 안주고 돈을 받아갔습니다';
  get date => '2024-03-28-18-25-56';
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
      body: SingleChildScrollView(
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
                  style: TextStyle(fontSize: 20,fontFamily: 'skybori'),
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
                  style: TextStyle(fontSize: 20,fontFamily: 'skybori'),
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
                  style: TextStyle(fontSize: 20,fontFamily: 'skybori'),
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
                      style: TextStyle(fontSize: 20,fontFamily: 'skybori'),
                    ),
                    Text(
                      '미처리',
                      style: TextStyle(fontSize: 20,fontFamily: 'skybori', color: Colors.red),
                    ),
                  ],
                )
              ),
            ),
            SizedBox(height: 10,),
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
              onPressed: () {
                CustomDialog.showAlert(
                    context,
                    "문의 / 신고글\n답변이 정상 등록되었습니다. ",
                    27,
                    Colors.black,
                        () {
                      // 답변 남기기 버튼이 눌렸을 때 이동할 페이지를 지정합니다
                          Get.to(ContactPage());
                    }
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}


class CustomDialog {
  static void showAlert(
      BuildContext context, String message, double fontSize, Color textColor,VoidCallback moveToPage) {
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
          content: Container(
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