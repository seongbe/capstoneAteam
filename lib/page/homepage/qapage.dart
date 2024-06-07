import 'dart:io';
import 'package:capstone/component/ImagePickerScreen.dart';
import 'package:capstone/component/alterdilog2.dart';
import 'package:capstone/component/button.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../component/alerdialog.dart';
import '../../controller/imagePickerController.dart';
import 'homePage.dart';


class QandApage extends StatefulWidget {
  const QandApage({super.key});

  @override
  State<QandApage> createState() => _QandApageState();
}

class _QandApageState extends State<QandApage> {
  final ImagePickerController controller = Get.put(ImagePickerController());

  final TextEditingController titleController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController detailController = TextEditingController();

  Future<void> uploadData() async {
    if (titleController.text.isEmpty ||
        typeController.text.isEmpty ||
        detailController.text.isEmpty) {
      CustomDialog2.showAlert(
        context, '모든 필드를 입력해주세요.', 14,Colors.black,);
      return;
    }

    try {
      List<String> imageUrls = [];
      for (var image in controller.pickedImages) {
        if (image != null) {
          String imageUrl = await uploadImageToFirebaseStorage(File(image.path));
          imageUrls.add(imageUrl);
        }
      }

// 현재 로그인한 사용자 정보 가져오기
      User? user = FirebaseAuth.instance.currentUser;
      String uid = user != null ? user.uid : 'unknown_user';

      //User컬렉션에서 문서명이 uid인 문서에서 user_id값 받아서 userId변수에 저장
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('User').doc(uid).get();
      String userId = userDoc.exists ? userDoc.get('user_id') : 'unknown_user';

// Firestore에 데이터 추가
      DocumentReference docRef = await FirebaseFirestore.instance.collection('ContactTest').add({
        'date': DateTime.now().toString(),
        'detail': detailController.text,
        'images_url': imageUrls,
        'inquiry_name': titleController.text,
        'inquiry_type': typeController.text,
        'state': false,
        'user_id': userId,
      });


      // 문서의 ID를 가져와서 contact_id 필드에 저장
      await docRef.update({'contact_id': docRef.id});

      // 작업이 완료되면 CustomDialog를 통해 알림 표시 후 Mypage로 이동
      CustomDialog.showAlert(
        context,
        '문의가 성공적으로 접수되었습니다.',
        18.0,
        Colors.black,
        () {
          Get.to(() => HomePage(2));
        },
      );
    } catch (error) {
      print('Error uploading images: $error');
      // 에러 처리
      CustomDialog2.showAlert(
        context, '오류가 발생했습니다.',14, Colors.black,
      );
    }

    titleController.clear();
    typeController.clear();
    detailController.clear();
    controller.clearImages();
  }

  Future<String> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('complaintImages/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (error) {
      print('Error uploading image to Firebase Storage: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '문의/신고',
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
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImagePickerScreen(),
              Divider(
                color: Color(0xffD0E4BC),
                thickness: 1.0,
              ),
              Text(
                '제목',
                style: TextStyle(
                  fontFamily: 'skybori',
                  fontSize: 20,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: '제목을 입력하세요.',
                  helperText: "* 필수 입력값입니다.",
                  hintStyle: TextStyle(color: Color(0xffC0C0C0), fontFamily: 'mitmi'),
                  filled: true,
                  fillColor: Color(0xffF8FFF2),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Color(0xffD0E4BC)),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                '문의/신고 유형',
                style: TextStyle(
                  fontFamily: 'skybori',
                  fontSize: 20,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: typeController,
                decoration: InputDecoration(
                  hintText: '문의 유형을 입력하세요.',
                  helperText: "* 필수 입력값입니다.",
                  hintStyle: TextStyle(color: Color(0xffC0C0C0), fontFamily: 'mitmi'),
                  filled: true,
                  fillColor: Color(0xffF8FFF2),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Color(0xffD0E4BC)),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                '문의 내용',
                style: TextStyle(
                  fontFamily: 'skybori',
                  fontSize: 20,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: detailController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: '문의사항과 신고에 대해 자세히 설명해주세요.',
                  helperText: "* 필수 입력값입니다.",
                  hintStyle: TextStyle(color: Color(0xffC0C0C0), fontFamily: 'mitmi'),
                  filled: true,
                  fillColor: Color(0xffF8FFF2),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Color(0xffD0E4BC)),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              GreenButton(
                text1: '신고하기', 
                width: 756,
                height: 50,
                onPressed: uploadData,
                ),
              
            ],
          ),
        ],
      ),
    );
  }
}
