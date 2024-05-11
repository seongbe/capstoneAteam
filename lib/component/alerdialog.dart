import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

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
    double popupHeight = textPainter.height + 44; // 상하 padding 고려

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