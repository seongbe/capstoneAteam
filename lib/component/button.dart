import 'package:flutter/material.dart';

class GreenButton extends StatelessWidget {
  final String text1;
  final double width;
  final double height;
  final VoidCallback? onPressed;
  final double textsize;
  final double letterspace;

  const GreenButton({
    Key? key,
    required this.text1,
    required this.width,
    this.height = 55,
    this.onPressed,
    this.textsize = 30,
    this.letterspace = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed ?? () {}, // 클릭 이벤트 추가
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Color(0xFF78BE39),
          border: Border.all(
            color: Color(0xFF66AA28),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text1,
            style: TextStyle(
              fontFamily: 'mitmi',
              fontSize: textsize,
              color: Colors.white,
              letterSpacing: letterspace,
            ),
          ),
        ),
      ),
    );
  }
}
