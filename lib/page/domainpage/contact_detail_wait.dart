import 'package:capstone/component/button.dart';
import 'package:capstone/page/domainpage/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                Get.to(ContactPage());
              },
            ),
        ],
        ),
      ),
    );
  }
}

