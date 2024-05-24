import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:capstone/component/button.dart';
import 'package:capstone/page/homepage/homepage.dart';
import 'package:capstone/page/onboarding/Certification.dart';
import 'package:capstone/page/onboarding/PasswordReset.dart';
import 'package:capstone/component/alerdialog.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: idController.text.trim(),
        password: passwordController.text.trim(),
      );
      // 로그인 성공 시 홈 페이지로 이동
      Get.to(() => HomePage());
    } on FirebaseAuthException catch (e) {
      // 오류 발생 시 다이얼로그 표시
      String message = '아이디나 비밀번호가 틀렸습니다.';
      CustomDialog.showAlert(context, message, 20, Colors.black, () {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenSize.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/domainPage_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 110),
                Image.asset(
                  'assets/images/skunivLogo.png',
                  width: 126.98,
                  height: 77.01,
                ),
                const Text(
                  '풀잎장터',
                  style: TextStyle(
                    fontFamily: 'mitmi',
                    color: Color(0xFF7AAC4D),
                    fontSize: 55,
                    letterSpacing: 3.0
                  ),
                ),
                const SizedBox(height: 120),
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: idController,
                    decoration: const InputDecoration(
                      labelText: '아이디를 입력하세요.',
                      labelStyle: TextStyle(
                        color: Color(0xffC0C0C0),
                        fontFamily: 'mitmi',
                      ),
                      filled: true,
                      fillColor: Color(0xffF8FFF2),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color(0xffD0E4BC),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: '비밀번호를 입력하세요.',
                      labelStyle: TextStyle(
                        color: Color(0xffC0C0C0),
                        fontFamily: 'mitmi',
                      ),
                      filled: true,
                      fillColor: Color(0xffF8FFF2),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Color(0xffD0E4BC),
                        ),
                      ),
                    ),
                    obscureText: true,
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(width: 30),
                    const Icon(Icons.check_box),
                    const SizedBox(width: 5),
                    const Text(
                      '로그인 상태 유지',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SKYBORI',
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.to(PasswordReset());
                      },
                      child: const Text(
                        '비밀번호 재설정',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.black,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          fontFamily: 'SKYBORI',
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                GreenButton(
                  text1: '로그인',
                  width: 288,
                  height: 55,
                  onPressed: login,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      '아직 회원이 아니신가요?',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SKYBORI',
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 30),
                    TextButton(
                      onPressed: () {
                        Get.to(Certification());
                      },
                      child: const Text(
                        '계정만들기',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFF78BE39),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF78BE39),
                        textStyle: const TextStyle(
                          fontFamily: 'SKYBORI',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
