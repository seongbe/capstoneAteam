import 'package:flutter/material.dart';

class ContactContainer_BLUE extends StatelessWidget {
  // 변수 정의
  final String inquiryName;
  final String inquiryType;
  final String id;
  final String date;

  const ContactContainer_BLUE({
    required this.inquiryName,
    required this.inquiryType,
    required this.id,
    required this.date,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 362,
      height: 180, // 높이 조정
      margin: EdgeInsets.fromLTRB(12, 7, 12, 12),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0x26E1F0D3),
        border: Border.all(
          color: Color(0xFFE1F0D3),
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '     문의 / 신고명 : ',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  inquiryName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '문의 / 신고 종류 : ',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  inquiryType,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '                      ID : ',
                  style: TextStyle(fontSize: 16),
                ),
                Expanded(
                  child: Text(
                    id,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5), // 간격 추가
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '                   날짜 : ',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  date,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '                   상태 : ',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '처리완료',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
