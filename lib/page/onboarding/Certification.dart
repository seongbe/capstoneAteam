import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capstone/page/onboarding/startPage.dart';
import 'package:capstone/component/button.dart';
import 'package:capstone/component/alterdilog2.dart';
import 'package:capstone/page/onboarding/SelectStudentInfo.dart'; // 추가 정보 입력 페이지

class Certification extends StatefulWidget {
  const Certification({Key? key}) : super(key: key);

  @override
  _CertificationState createState() => _CertificationState();
}

class _CertificationState extends State<Certification> with WidgetsBindingObserver {
  final TextEditingController _emailController = TextEditingController();
  bool isSent = false;
  User? user;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> deleteUser() async {
    if (user != null) {
      try {
        await user!.delete();
      } catch (e) {
        // 사용자 삭제 중에 오류가 발생한 경우 예외 처리를 수행합니다.
        print('사용자 삭제 중 오류 발생: $e');
        // 오류 메시지를 사용자에게 표시할 수도 있습니다.
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController.clear(); // 이메일 텍스트 필드 초기화
    WidgetsBinding.instance.addObserver(this);
  }

  //AppLifecycleState.detached
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference usersCollection = firestore.collection('User');
    String uid = FirebaseAuth.instance.currentUser!.uid;

    usersCollection.doc(uid).get().then((DocumentSnapshot snapshot) {
      if (!snapshot.exists) {
        // 사용자 정보가 없으면 삭제 가능
        if (state == AppLifecycleState.detached) {
          deleteUser();
          Get.offAll(StartPage());
        }
      } else {
        // 사용자 정보가 있으면 아무 동작도 하지 않음
        print('Firestore에 사용자 정보가 있어서 삭제를 막습니다.');
      }
    });
  }



  Future<void> _sendVerificationEmail() async {
    try {
      String email = _emailController.text.trim();

      if (!GetUtils.isEmail(email)) {
        CustomDialog2.showAlert(
            context, "유효한 이메일 주소를 입력해주세요.", 20, Colors.black);
        return;
      }

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference usersCollection = firestore.collection('User');

      // 이메일이 이미 등록되어 있는지 확인
      QuerySnapshot querySnapshot = await usersCollection
          .where('user_id', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        CustomDialog2.showAlert(
            context, "이미 가입된 계정입니다.", 20, Colors.black);
        return;
      }


      FirebaseAuth auth = FirebaseAuth.instance;

      // Firebase를 사용하여 사용자 생성
      await auth.createUserWithEmailAndPassword(
          email: email, password: 'temporaryPassword');
      user = auth.currentUser;

      if (user != null && !user!.emailVerified) {
        // 이메일 인증 메일 전송
        await user!.sendEmailVerification();

        setState(() {
          isSent = true;
        });

        CustomDialog2.showAlert(
            context, "입력한 이메일 주소로 인증 메일이 발송되었습니다.", 20, Colors.black);
      }
    } catch (e) {
      CustomDialog2.showAlert(context, "오류가 발생했습니다: $e", 20, Colors.black);
    }
  }

  Future<void> _checkEmailVerified() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    user = auth.currentUser;

    await user!.reload();
    user = auth.currentUser;  // reload 후에 user를 다시 가져옵니다

    if (isSent && user!.emailVerified) {
      // 이메일 인증이 완료된 경우 추가 정보 입력 페이지로 이동
      Get.off(() => Selectstudentinfo(user: user, email: _emailController.text));
    } else {
      // 이메일 인증이 완료되지 않은 경우 경고 메시지 표시
      CustomDialog2.showAlert(
          context, "이메일 인증이 완료되지 않았습니다. 이메일을 확인해주세요.", 20, Colors.black);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // 사용자 삭제 시도
        await deleteUser();
        // 뒤로 가기 동작 수행
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('회원가입'),
          titleTextStyle: const TextStyle(
              fontSize: 40, color: Colors.black, fontFamily: 'mitmi'),
          shape: const Border(
              bottom: BorderSide(color: Colors.grey, width: 1)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              deleteUser();
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
                            borderSide: BorderSide(
                                width: 1, color: Color(0xffD0E4BC)),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                    GreenButton(
                      text1: '인증 메일 받기',
                      width: 300,
                      height: 55,
                      onPressed: _sendVerificationEmail,
                    ),
                    const SizedBox(height: 20),
                    GreenButton(
                      text1: '이메일 인증 확인',
                      width: 340,
                      height: 55,
                      onPressed: _checkEmailVerified,
                    ),
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