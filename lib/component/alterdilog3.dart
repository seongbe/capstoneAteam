import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog3 {
  static void showAlert(BuildContext context, String message, double fontSize,
      Color textColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 20,
            ),
            AlertDialog(
              backgroundColor: Color(0xFFCFE4BC),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                    SizedBox(height: 20),
                  ],
                ),
              ),
              actions: [], // actions 비우기
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // 확인 버튼을 눌렀을 때 수행할 작업 추가
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF78BE39), // 버튼의 배경색
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(50), // 버튼의 모서리를 둥글게 만듭니다.
                      side: BorderSide(
                          width: 1.50, color: Color(0xFF65AA28)), // 버튼의 테두리 설정
                    ),
                  ),
                  child: Text('확인',
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
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    // 확인 버튼을 눌렀을 때 수행할 작업 추가
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF78BE39), // 버튼의 배경색
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(50), // 버튼의 모서리를 둥글게 만듭니다.
                      side: BorderSide(
                          width: 1.50, color: Color(0xFF65AA28)), // 버튼의 테두리 설정
                    ),
                  ),
                  child: Text('취소',
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

  static void showConfirmationDialog(BuildContext context, String alertMessage, Future<Null> Function() callback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 20),
            AlertDialog(
              backgroundColor: Color(0xFFCFE4BC),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      alertMessage,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'mitmi',
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // 확인 버튼을 누를 때
                        await callback();
                        Navigator.of(context).pop(); // 콜백 함수 실행 후 다이얼로그 닫기
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF78BE39), // 버튼의 배경색
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50), // 버튼의 모서리 설정
                          side: BorderSide(
                            width: 1.50,
                            color: Color(0xFF65AA28), // 버튼의 테두리 설정
                          ),
                        ),
                      ),
                      child: Text(
                        '확인',
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
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        // 취소 버튼을 누를 때
                        Navigator.of(context).pop(); // 다이얼로그 닫기
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF78BE39), // 버튼의 배경색
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50), // 버튼의 모서리 설정
                          side: BorderSide(
                            width: 1.50,
                            color: Color(0xFF65AA28), // 버튼의 테두리 설정
                          ),
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
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }


}
