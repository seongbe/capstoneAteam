import 'package:flutter/material.dart';
import 'package:get/get.dart'; // GetX 패키지 가져오기

class ChatButton extends StatelessWidget {
  final String text1;
  final double width;
  final double height;
  final VoidCallback? onPressed;
  final double textsize;

  const ChatButton({
    Key? key,
    required this.text1,
    required this.width,
    this.height = 55,
    this.onPressed,
    this.textsize = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed != null ? onPressed : () {}, // 클릭 이벤트 추가
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Color(0xFF78BE39),
          border: Border.all(
            color: Color(0xFF66AA28),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text1,
            style: TextStyle(
              fontFamily: 'mitmi',
              fontSize: textsize,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
