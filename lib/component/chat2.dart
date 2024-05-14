import 'package:flutter/material.dart';

class leftChatting extends StatelessWidget {
  final String text;

  const leftChatting({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 154.80,
        height: 34.26,
        decoration: ShapeDecoration(
          color: Color(0xFFFCE9BE),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFFD0E4BC)),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF484848),
              fontSize: 13,
              fontFamily: 'Noto Sans KR',
              fontWeight: FontWeight.w400,
              height: 0.13,
            ),
          ),
        ));
  }
}
