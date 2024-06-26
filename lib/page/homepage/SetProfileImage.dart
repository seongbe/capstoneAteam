import 'dart:io';
import 'package:capstone/component/button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:capstone/component/alerdialog.dart';

import 'homePage.dart';

class SetProfileImage extends StatefulWidget {
  const SetProfileImage({Key? key}) : super(key: key);

  @override
  State<SetProfileImage> createState() => _SetProfileImageState();
}

class _SetProfileImageState extends State<SetProfileImage> {
  XFile? _pickedFile;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('User');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController _nicknameController = TextEditingController();

  String? _profileUrl;
  String? _currentNickname; // 현재 로그인된 사용자의 닉네임

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> userInfo =
            await _firestore.collection('User').doc(user.uid).get();
        setState(() {
          _profileUrl = userInfo['profile_url'];
          _nicknameController.text = userInfo['nickname'];
          _currentNickname = userInfo['nickname']; // 현재 닉네임 설정
        });
      }
    } catch (e) {
      print('Failed to fetch user profile: $e');
    }
  }

  Future<bool> _checkNickname(String nickname) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference usersCollection = firestore.collection('User');

    if (nickname == _currentNickname) {// 기존 닉네임과 동일시 true
      return true;
    } else {
      // 닉네임 중복 여부 확인
      QuerySnapshot querySnapshot =
          await usersCollection.where('nickname', isEqualTo: nickname).get();

      return querySnapshot.docs.isEmpty; // 중복된 닉네임이 없으면 true 반환
    }
  }

  Future<void> _uploadProfile() async {
    if (_pickedFile != null) {
      try {
        final now = DateTime.now();
        var ref = storage.ref().child('profileImages/$now.jpg');
        await ref.putFile(File(_pickedFile!.path));
        String downloadURL = await ref.getDownloadURL();

        // 업로드된 이미지 URL을 Firestore에 업데이트
        String userId = FirebaseAuth.instance.currentUser!.uid;
        await FirebaseFirestore.instance.collection('User').doc(userId).update({
          'profile_url': downloadURL,
        });
      } catch (e) {
        print('Failed to upload image: $e');
      }
    } else {
      if (kDebugMode) {
        print('No image selected');
      }
    }
  }

  Future<void> _updateNickname() async {
    // 닉네임이 공백인지 체크
    String newNickname = _nicknameController.text.trim();
    if (newNickname.isEmpty) {
      CustomDialog.showAlert(
        context,
        "공백은 사용하실 수 없습니다",
        20,
        Colors.black,
        () {},
      );
      return;
    }

    // 닉네임 중복 확인
    if (!await _checkNickname(newNickname)) {
      CustomDialog.showAlert(
        context,
        "이미 사용 중인 닉네임입니다. 다른 닉네임을 입력해주세요.",
        20,
        Colors.black,
        () {},
      );
      return;
    }

    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('User').doc(userId).update({
        'nickname': newNickname,
      });
      setState(() {
        _currentNickname = newNickname; // 현재 닉네임 업데이트
      });
    } catch (e) {
      print('Failed to update nickname: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    const imageSize = 150.0;

    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    final containerSize = screenWidth;
    final ImagePicker picker = ImagePicker();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '프로필 수정',
            style: TextStyle(
              fontFamily: 'skybori',
              fontSize: 30,
              letterSpacing: 2.0,
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
          children: [
            SizedBox(height: 50),
            Stack(
              children: [
                Positioned(
                  right: 60,
                  top: 100,
                  child: IconButton(
                    highlightColor: Colors.white,
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.black45,
                      size: 40,
                    ),
                    onPressed: () {
                      _showBottomSheet();
                    },
                  ),
                ),
                if (_pickedFile == null)
                  Center(
                    child: Container(
                      width: imageSize,
                      height: imageSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2,
                          color: Colors.black12,
                        ),
                        image: _profileUrl != null && _profileUrl!.isNotEmpty
                            ? DecorationImage(
                                image: NetworkImage(_profileUrl!),
                                fit: BoxFit.cover,
                              )
                            : DecorationImage(
                                image: AssetImage('assets/images/skon_fly.png'),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  )
                else
                  Center(
                    child: Container(
                      width: imageSize,
                      height: imageSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 2, color: Colors.black12),
                        image: DecorationImage(
                          image: FileImage(File(_pickedFile!.path)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 50),
            Text(
              '닉네임',
              style: TextStyle(
                fontFamily: 'skybori',
                fontSize: 20,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _nicknameController,
              decoration: InputDecoration(
                hintText: '바꾸고 싶은 닉네임을 입력해주세요.',
                hintStyle:
                    TextStyle(color: Color(0xffC0C0C0), fontFamily: 'mitmi'),
                filled: true,
                fillColor: Color(0xffF8FFF2),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(width: 1, color: Color(0xffD0E4BC)),
                ),
              ),
            ),
            SizedBox(height: 40),
            GreenButton(
              text1: '프로필수정',
              width: 756,
              height: 50,
              onPressed: () async {
                // 닉네임 업데이트 및 프로필 사진 업로드
                await _updateNickname();
                if (_currentNickname != null &&
                    _nicknameController.text.trim() != _currentNickname) {
                  return; // 닉네임이 중복이거나 공백일 경우, 프로필 수정 완료 팝업 창을 띄우지 않음
                }
                await _uploadProfile();
                CustomDialog.showAlert(
                  context,
                  "프로필 수정이 완료되었습니다.",
                  20,
                  Colors.black,
                  () {
                    Get.offAll(HomePage(2));
                  },
                );
              },
              letterspace: 30,
            ),
          ],
        ),
      ),
    );
  }

  _showBottomSheet() {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return Container(
          height: 200,
          width: MediaQuery.of(context).size.width,
          color: Color(0xffD0E4BC),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _getCameraImage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffD0E4BC),
                  surfaceTintColor: Color(0xffD0E4BC),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  fixedSize: Size(300, 60),
                ),
                child: const Text(
                  '사진찍기',
                  style: TextStyle(
                    fontFamily: 'skybori',
                    fontSize: 20,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _getPhotoLibraryImage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffD0E4BC),
                  surfaceTintColor: Color(0xffD0E4BC),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  fixedSize: Size(300, 60),
                ),
                child: const Text(
                  '라이브러리에서 불러오기',
                  style: TextStyle(
                    fontFamily: 'skybori',
                    fontSize: 20,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _getCameraImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    } else {
      if (kDebugMode) {
        print('이미지 선택안함');
      }
    }
  }

  _getPhotoLibraryImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = XFile(pickedFile.path);
      });
    } else {
      if (kDebugMode) {
        print('이미지 선택안함');
      }
    }
  }
}
