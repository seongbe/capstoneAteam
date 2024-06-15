import 'package:capstone/page/homepage/qapage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class CustomDialogContact {
  static void showAlert(BuildContext context, String message, double fontSize,
      Color textColor) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 20),
            AlertDialog(
              contentPadding: EdgeInsets.all(40), // Adding padding
              backgroundColor: Color(0xFFCFE4BC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
                side: BorderSide(
                  color: Color(0xFF65AA28),
                  width: 1.3,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 23),
                    Text(
                      message,
                      style: TextStyle(
                        color: textColor,
                        fontFamily: 'mitmi',
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              actions: [],
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.off(QandApage());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF78BE39),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(width: 1.50, color: Color(0xFF65AA28)),
                    ),
                  ),
                  child: Text(
                    ' 문의하기',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontFamily: 'mitmi',
                      fontWeight: FontWeight.w400,
                      height: 0.03,
                      letterSpacing: 9.45,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    print('취소 버튼');
                    Navigator.of(context).pop(); // 현재 화면 닫기

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF78BE39),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(width: 1.50, color: Color(0xFF65AA28)),
                    ),
                  ),
                  child: Text(
                      '취소',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontFamily: 'mitmi',
                        fontWeight: FontWeight.w400,
                        height: 0.03,
                        letterSpacing: 9.45,
                      )),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}