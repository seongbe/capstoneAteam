import 'package:capstone/component/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Yaksookget extends StatelessWidget {
  const Yaksookget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () {
              Get.back();
            },
          ),
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '약속 잡기',
                    style: TextStyle(
                      fontFamily: 'skybori',
                      fontSize: 30,
                      letterSpacing: 2.0,
                    ),
                  ),
                  Image(
                    width: 76,
                    height: 70,
                    image: AssetImage(
                      'assets/images/skon_fly.png',
                    ),
                  ),
                ],
              ),
              Divider(
                height: 10.0,
                color: Color(0xffCCCCCC),
                thickness: 1.0,
                endIndent: 30.0,
              ),
            ],
          ),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
          children: <Widget>[
            SizedBox(
              // 알림 창 들어가는 곳
              height: 150,
            ),
            Text(
              '약속시간',
              style: TextStyle(
                fontFamily: 'skybori',
                fontSize: 20,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelStyle:
                    TextStyle(color: Color(0xffC0C0C0), fontFamily: 'mitmi'),
                filled: true,
                fillColor: Color(0xffF8FFF2),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(width: 1, color: Color(0xffD0E4BC)),
                ),
              ),
              obscureText: true, //비밀번호 안 보이게
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '비밀번호를 입력해주세요.';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '약속 알람받기',
              style: TextStyle(
                fontFamily: 'skybori',
                fontSize: 20,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              '     약속 30분전',
              style: TextStyle(
                fontFamily: 'skybori',
                fontSize: 20,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(
              height: 60.0,
            ),
            GreenButton(text1: '저장하기', width: 288)
          ],
        ),
      ),
    );
  }
}
