import 'package:flutter/material.dart';
import 'package:capstone/component/alerdialog.dart';
import 'dart:async';
import 'package:capstone/component/button.dart';
import 'package:capstone/page/onboarding/PasswordReset.dart';
import 'package:flutter/rendering.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';

class PasswordCertification extends StatefulWidget {
  const PasswordCertification({Key? key}) : super(key: key);

  @override
  _PasswordCertificationState createState() => _PasswordCertificationState();
}

class _PasswordCertificationState extends State<PasswordCertification> {
  late Timer _timer;
  int _secondsRemaining = 60;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String getFormattedTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('비밀번호 재설정'),
          titleTextStyle: const TextStyle(
              fontSize: 40, color: Colors.black, fontFamily: 'mitmi'),
          shape: const Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back(); // 뒤로 가기
            },
          ),
          actions: [
            Image.asset('assets/images/skon_fly.png'),
            SizedBox(width: 10),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                width: 300,
                height: 150,
                decoration: BoxDecoration(
                  color: Color(0xffD0E4BC), // 배경색 설정
                  border: Border.all(color: Colors.green), // 테두리 색상 및 두께 설정
                  borderRadius: BorderRadius.circular(20.0), // 테두리 모서리를 둥글게 만들기 위한 설정
                ),
                child: Center(
                  child: Text(
                    '메일 확인 후,\n 4자리 인증번호를 입력하세요!',
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'SKYBORI',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              const SizedBox(
                height: 40,
              ),

              Container(
                width: 200,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '인증번호',
                    labelStyle: TextStyle(
                        color: Color(0xffC0C0C0),
                        fontFamily: 'mitmi'),
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Text(
                '${getFormattedTime(_secondsRemaining)}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,),
              ),

              SizedBox(
                height: 30,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('코드를 잊으셨나요?',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SKYBORI',
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        CustomDialog.showAlert(context, "이메일로 인증번호를 발송했습니다.", 20, Colors.black,(){});
                        _secondsRemaining = 60; // 타이머 리
                        startTimer();// 셋
                      });
                    },
                    child: Text('다시 보내기',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFF78BE39),
                        )),
                    style: TextButton.styleFrom(
                      foregroundColor: Color(0xFF78BE39),
                      textStyle: const TextStyle(
                        fontFamily: 'SKYBORI',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              GreenButton(
                text1: '인증하기',
                width: 300,
                height: 55,
                onPressed: () {
                  CustomDialog.showAlert(context, "인증이 완료되었습니다.", 20, Colors.black,(){Get.to(PasswordReset());});
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}