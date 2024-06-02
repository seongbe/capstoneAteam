import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _changePassword() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        // 현재 비밀번호 확인
        String email = user.email!;
        String currentPassword = _currentPasswordController.text.trim();
        String newPassword = _newPasswordController.text.trim();

        // 사용자 재인증
        AuthCredential credential = EmailAuthProvider.credential(email: email, password: currentPassword);
        await user.reauthenticateWithCredential(credential);

        // 비밀번호 업데이트
        await user.updatePassword(newPassword);
        await _auth.signOut(); // 비밀번호 변경 후 재로그인 필요
        Get.offAllNamed('/login'); // 로그인 페이지로 이동

        Get.snackbar('성공', '비밀번호가 성공적으로 변경되었습니다.');
      }
    } catch (e) {
      Get.snackbar('오류', '비밀번호 변경 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('비밀번호 변경'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _currentPasswordController,
              decoration: InputDecoration(labelText: '현재 비밀번호'),
              obscureText: true,
            ),
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(labelText: '새 비밀번호'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changePassword,
              child: Text('비밀번호 변경'),
            ),
          ],
        ),
      ),
    );
  }
}
