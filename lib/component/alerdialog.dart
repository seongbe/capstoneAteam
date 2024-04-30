import 'package:flutter/material.dart';

class CustomDialog {
  static void showAlert(
      BuildContext context, String message, double fontSize, Color textColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFCFE4BC),
          content: SizedBox(
            height: 50,
            child: Container(
              child: Center(
                child: Text(
                  message,
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w400,
                    height: 0.07,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          actions: <Widget>[],
        );
      },
    );
  }
}
