import 'package:capstone/component/alterdilog2.dart';
import 'package:capstone/component/alterdilog3.dart';
import 'package:capstone/component/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capstone/page/onboarding/StartPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Accountdelete extends StatelessWidget {
  const Accountdelete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    // Container의 너비와 높이를 동일하게 설정합니다.
    final containerSize = screenWidth;
    return MaterialApp(
      title: 'Set_Profile_Page',
      debugShowCheckedModeBanner: false,
      home: Inputpass(),
    );
  }
}

class Inputpass extends StatefulWidget {
  const Inputpass({Key? key}) : super(key: key);

  @override
  _InputpassState createState() => _InputpassState();
}

class _InputpassState extends State<Inputpass> {
  final TextEditingController passwordController = TextEditingController();

  void _validateAndNavigate() {
    String password = passwordController.text;

    // 사용자의 현재 비밀번호 가져오기
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );

      // 비밀번호 확인 후 다음 페이지로 이동
      user.reauthenticateWithCredential(credential).then((value) {
        CustomDialog3.showConfirmationDialog(
          context,
          '모든 활동 기록이 삭제됩니다.\n '
              '진행하시겠습니까?\n',
              () async {
            deleteUser();
            await Get.offAll(StartPage());
            return Future.value(); // 예시: 비동기적으로 작업을 수행하지 않는 경우에 사용
          },
        );
      }).catchError((error) {
        String message = '비밀번호가 일치하지 않습니다.';
        CustomDialog2.showAlert(context, message, 20, Colors.black);
      });
    }
  }

  Future<void> deleteUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        String userId = user.uid;

        // 사용자가 작성한 게시물을 먼저 삭제합니다.
        await deletePostsByUser(userId);

        // Firestore에서 사용자 데이터 삭제
        await deleteUserData(userId);

        // Firebase Authentication에서 사용자 삭제
        await user.delete();
      } catch (e) {
        String message = '계정 삭제 중 오류가 발생했습니다: $e';
        CustomDialog2.showAlert(context, message, 20, Colors.black,);
      }
    }
  }

  Future<void> deletePostsByUser(String userId) async {
    try {
      // 해당 사용자가 작성한 모든 게시물을 Firestore에서 삭제합니다.
      QuerySnapshot postsSnapshot = await FirebaseFirestore.instance.collection('Product').where('user_id', isEqualTo: userId).get();
      postsSnapshot.docs.forEach((doc) async {
        await doc.reference.delete();
      });
    } catch (e) {
      String message = '게시물 삭제 중 오류가 발생했습니다: $e';
      CustomDialog2.showAlert(context, message, 20, Colors.black);
    }
  }

  Future<void> deleteUserData(String userId) async {
    try {
      // 사용자 데이터가 있는 Firestore 컬렉션의 문서를 삭제
      await FirebaseFirestore.instance.collection('User').doc(userId).delete();
    } catch (e) {
      String message = '계정 삭제 중 오류가 발생했습니다: $e';
      CustomDialog2.showAlert(context, message, 20, Colors.black,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '회원 탈퇴',
          style: TextStyle(
            fontFamily: 'skybori',
            fontSize: 30,
            letterSpacing: 5.0,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          Image.asset('assets/images/skon_fly.png'),
          SizedBox(width: 20),
        ],
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.8,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
        children: <Widget>[
          Container(
            height: 135,
            width: 280,
            margin: EdgeInsets.only(left: 30.0, top: 30.0, right: 30.0, bottom: 20.0),
            decoration: BoxDecoration(
              border: Border.all(width: 1.7, color: Color(0xffD0E4BC)),
              borderRadius: BorderRadius.circular(40),
              color: Color(0xffF8FFF2),
            ),
            child: Center(
              child: Text(
                '본인 확인을 위해 \n비밀번호를 입력해주세요.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'skybori',
                  fontSize: 20,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ),
          Text(
            '비밀번호',
            style: TextStyle(
              fontFamily: 'skybori',
              fontSize: 20,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: '비밀번호를 입력하세요.',
              helperText: "* 필수 입력값입니다.",
              helperStyle: TextStyle(color: Color(0xffC0C0C0), fontFamily: 'mitmi'),
              labelStyle: TextStyle(color: Color(0xffC0C0C0), fontFamily: 'mitmi'),
              filled: true,
              fillColor: Color(0xffF8FFF2),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(width: 1, color: Color(0xffD0E4BC)),
              ),
            ),
            obscureText: true, // 비밀번호 안 보이게
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '비밀번호를 입력해주세요.';
              }
              return null;
            },
          ),
          GreenButton(
            text1: '본인인증',
            width: 756,
            height: 50,
            onPressed: _validateAndNavigate,
          ),
        ],
      ),
    );
  }
}