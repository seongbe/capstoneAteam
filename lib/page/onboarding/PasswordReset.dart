import 'package:capstone/page/onboarding/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capstone/component/button.dart';
import 'package:capstone/component/alerdialog.dart';
import 'package:capstone/component/alterdilog2.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({Key? key}) : super(key: key);

  @override
  _PasswordReset createState() => _PasswordReset();
}

class _PasswordReset extends State<PasswordReset>
    with WidgetsBindingObserver {
  final TextEditingController _emailController = TextEditingController();
  User? user;

  @override
  void initState() {
    super.initState();
    _emailController.clear(); // 이메일 텍스트 필드 초기화
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> _sendVerificationEmail() async {
    try {
      String email = _emailController.text.trim();

      if (!GetUtils.isEmail(email)) {
        CustomDialog.showAlert(
            context, "유효한 이메일 주소를 입력해주세요.", 20, Colors.black,() {});
        return;
      }

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference usersCollection = firestore.collection('User');

      // 이메일이 이미 등록되어 있는지 확인
      QuerySnapshot querySnapshot =
      await usersCollection.where('user_id', isEqualTo: email).get();

      if (!querySnapshot.docs.isNotEmpty) {
        CustomDialog.showAlert(context, "가입된 계정이 아닙니다.", 20, Colors.black,() {});
        return;
      }

      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.sendPasswordResetEmail(email: email);


      CustomDialog.showAlert(
          context, "입력한 이메일 주소로 인증 메일이 발송되었습니다.", 20, Colors.black,() {Get.to(loginpage());});
    } catch (e) {
      CustomDialog2.showAlert(context, "오류가 발생했습니다: $e", 20, Colors.black);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('비밀번호 재설정'),
          titleTextStyle: const TextStyle(
              fontSize: 40, color: Colors.black, fontFamily: 'mitmi'),
          shape: const Border(bottom: BorderSide(color: Colors.grey, width: 1)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            Image.asset('assets/images/skon_fly.png'),
            const SizedBox(width: 10),
          ],
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: const [
                        SizedBox(width: 35),
                        Text('이메일 주소(아이디로 사용됩니다.)',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'SKYBORI',
                              fontSize: 20,
                            )),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 350,
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'example@example.com',
                          labelStyle: TextStyle(
                              color: Color(0xffC0C0C0), fontFamily: 'mitmi'),
                          filled: true,
                          fillColor: Color(0xffF8FFF2),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                            BorderSide(width: 1, color: Color(0xffD0E4BC)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GreenButton(
                      text1: '인증 메일 받기',
                      width: 288,
                      height: 55,
                      onPressed: _sendVerificationEmail,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
