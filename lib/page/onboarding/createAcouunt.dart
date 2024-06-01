import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:capstone/component/button.dart';
import 'package:capstone/page/homepage/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore import 추가
import 'package:capstone/component/alerdialog.dart';
import 'package:capstone/page/onboarding/loginpage.dart';

class CreatAccount extends StatefulWidget {
  final User? user; // Certification 페이지로부터 전달된 사용자 객체
  final String email; // Certification 페이지로부터 전달된 이메일

  CreatAccount({Key? key, required this.user, required this.email})
      : super(key: key);

  @override
  _CreatAccountState createState() => _CreatAccountState();
}

class _CreatAccountState extends State<CreatAccount> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String confirmnickname = '';
  late String email;

  Future<void> checkLoginStatus() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // 사용자가 로그인되어 있음
      print('사용자가 로그인되어 있습니다.');
    } else {
      // 사용자가 로그인되어 있지 않음
      print('사용자가 로그인되어 있지 않습니다.');
    }
  }

  // 닉네임 중복 확인 메서드
  Future<bool> _checkNickname() async {
    String nickname = _nicknameController.text.trim();

    // Firestore 인스턴스 생성
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference usersCollection = firestore.collection('User');

    // 닉네임 중복 여부 확인
    QuerySnapshot querySnapshot =
        await usersCollection.where('nickname', isEqualTo: nickname).get();

    if (querySnapshot.docs.isNotEmpty) {
      return false; // 중복된 닉네임이 있음
    } else {
      confirmnickname = nickname;
      return true; // 중복되지 않은 닉네임임
    }
  }

  // 비밀번호 확인 메서드
  bool _checkPassword() {
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;
    return password == confirmPassword; // 비밀번호가 일치하면 true 반환
  }

  void SaveToFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference usersCollection = firestore.collection('User');

    // Certification 페이지로부터 전달된 사용자 객체의 UID와 이메일을 가져옵니다.
    String uid = widget.user!.uid;
    String email = widget.email;

    String nickname = _nicknameController.text.trim();

    // Firestore에 사용자의 이메일을 저장합니다.
    await usersCollection.doc(uid).set({
      'created_at': FieldValue.serverTimestamp(),
      // Firebase 서버 시간을 사용하여 생성 시간을 기록합니다.
      'nickname': nickname,
      'popular': 0,
      'profile_url': "", //empty값으로 초기화
      'status': false,
      'user_id': email
    });
  }

  Future<void> deleteUser() async {
    if (widget.user != null) {
      try {
        await widget.user!.delete();
      } catch (e) {
        // 사용자 삭제 중에 오류가 발생한 경우 예외 처리를 수행합니다.
        print('사용자 삭제 중 오류 발생: $e');
        // 오류 메시지를 사용자에게 표시할 수도 있습니다.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '회원가입',
          style: TextStyle(
            fontSize: 40,
            color: Colors.black,
            fontFamily: 'mitmi',
          ),
        ),
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            deleteUser(); // 뒤로가기 버튼을 누를 때 deleteUser 함수 호출
            Get.back();
          },
        ),
        actions: [
          Image.asset('assets/images/skon_fly.png'),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 35),
                  Text(
                    '닉네임',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SKYBORI',
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 220,
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Zㄱ-ㅎ가-힣]')),
                      ],
                      controller: _nicknameController,
                      decoration: InputDecoration(
                        labelText: '닉네임을 입력하세요',
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
                  SizedBox(
                    child: GreenButton(
                      text1: '중복확인',
                      width: 80,
                      height: 40,
                      onPressed: () async {
                        String nickname = _nicknameController.text.trim();
                        if (nickname.isEmpty) {
                          CustomDialog.showAlert(
                            context,
                            "닉네임을 입력해주세요.",
                            20,
                            Colors.black,
                            () {},
                          );
                          return;
                        }

                        if (await _checkNickname()) {
                          CustomDialog.showAlert(context, "사용할 수 있는 닉네임 입니다.",
                              20, Colors.black, () {});
                        } else {
                          CustomDialog.showAlert(
                            context,
                            "이미 사용중인 닉네임 입니다.\n 새로운 닉네임을 입력하세요.",
                            20,
                            Colors.black,
                            () {},
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 35),
                  Text(
                    '비밀번호',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SKYBORI',
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '비밀번호를 입력하세요',
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
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 35),
                  Text(
                    '비밀번호 확인',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SKYBORI',
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '비밀번호를 한 번 더 입력하세요',
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
              SizedBox(height: 50),
              GreenButton(
                text1: '회원가입 완료',
                width: 300,
                height: 55,
                onPressed: () async {
                  // 닉네임 공백 확인
                  String nickname = _nicknameController.text.trim();
                  String password = _passwordController.text;

                  if (nickname.isEmpty) {
                    CustomDialog.showAlert(
                      context,
                      "닉네임을 입력해주세요.",
                      20,
                      Colors.black,
                      () {},
                    );
                    return;
                  }

                  if (nickname != confirmnickname) {
                    CustomDialog.showAlert(
                      context,
                      "중복확인을 해주세요.",
                      20,
                      Colors.black,
                      () {},
                    );
                    return;
                  }

                  // 닉네임 중복 확인
                  if (!await _checkNickname()) {
                    CustomDialog.showAlert(
                      context,
                      "이미 사용 중인 닉네임입니다.\n새로운 닉네임을 입력하세요.",
                      20,
                      Colors.black,
                      () {},
                    );
                    return;
                  }

                  //비밀번호 길이 확인
                  if (password.length < 6) {
                    CustomDialog.showAlert(
                      context,
                      "비밀번호는 6자리 이상이어야 합니다.",
                      20,
                      Colors.black,
                      () {},
                    );
                    return;
                  }

                  // 비밀번호 일치 여부 확인
                  if (!_checkPassword()) {
                    CustomDialog.showAlert(
                      context,
                      "비밀번호가 일치하지 않습니다.\n다시 입력해주세요.",
                      20,
                      Colors.black,
                      () {},
                    );
                    checkLoginStatus();
                    return;
                  }

                  User? user = FirebaseAuth.instance.currentUser;
                  String confirmPassword = _confirmPasswordController.text;

                  try {
                    await user!.updatePassword(confirmPassword);
                    SaveToFirestore();
                  } catch (e) {
                    print('오류 발생: $e');
                  }

                  checkLoginStatus();

                  // 회원가입 완료 시 로그인 페이지로 이동
                  CustomDialog.showAlert(
                    context,
                    "회원가입이 완료되었습니다.",
                    20,
                    Colors.black,
                    () {
                      Get.to(HomePage());
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
