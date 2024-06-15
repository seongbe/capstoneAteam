import 'dart:io';
import 'package:capstone/component/ImagePickerScreen.dart';
import 'package:capstone/component/alerdialog.dart';
import 'package:capstone/component/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../controller/imagePickerController.dart';

class PostWritePage extends StatefulWidget {
  const PostWritePage({super.key});

  @override
  _PostWritePageState createState() => _PostWritePageState();
}

class _PostWritePageState extends State<PostWritePage> {
  final ImagePickerController controller = Get.put(ImagePickerController());

  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController detailController = TextEditingController();

  Future<void> uploadData() async {
    if (titleController.text.isEmpty ||
        priceController.text.isEmpty ||
        detailController.text.isEmpty) {
      CustomDialog.showAlert(
        context,
        '모든 필드를 입력해주세요.',
        14,
        Colors.black,
            () {},
      );
      return;
    }

    // 이미지가 선택되지 않았을 경우 경고 표시
    if (controller.pickedImages.isEmpty) {
      CustomDialog.showAlert(
        context,
        '사진을 선택해주세요.',
        18,
        Colors.black,
            () {},
      );
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
      String userId = user != null ? user.uid : 'unknown_user';

      // Firestore에 데이터 추가
      DocumentReference docRef = await FirebaseFirestore.instance.collection('Product').add({
        'created_at': DateTime.now().toString(),
        'title': titleController.text,
        'price': priceController.text,
        'description': detailController.text,
        'like_count': 0,
        'image_url': imageUrls,
        'user_id': userId,
      });

      // 문서의 ID를 가져와서 post_id 필드에 저장
      await docRef.update({'post_id': docRef.id});

      // 작업이 완료되면 CustomDialog를 통해 알림 표시 후 이전 페이지로 이동
      CustomDialog.showAlert(
        context,
        '게시물이 성공적으로 등록되었습니다.',
        18.0,
        Colors.black,
            () {
          Get.back();
        },
      );
    } catch (error) {
      print('Error uploading images: $error');
      // 에러 처리
      CustomDialog.showAlert(
        context,
        '오류가 발생했습니다.',
        14,
        Colors.black,
            () {},
      );
    }

    titleController.clear();
    priceController.clear();
    detailController.clear();
    controller.clearImages();
  }


  Future<String> uploadImageToFirebaseStorage(File imageFile) async {
    try {
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('product/${DateTime.now().millisecondsSinceEpoch}.jpg');
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
          '게시물 작성',
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
        // actions: [
        //   Text(
        //     '임시저장',
        //     style: TextStyle(
        //       color: Color(0xFF78BE39),
        //       fontSize: 20,
        //       fontFamily: 'skybori',
        //     ),
        //   ),
        //   SizedBox(width: 20),
        // ],
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
                '가격',
                style: TextStyle(
                  fontFamily: 'skybori',
                  fontSize: 20,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: priceController,
                decoration: InputDecoration(
                  hintText: '가격을 입력해 주세요',
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
                '자세한 설명',
                style: TextStyle(
                  fontFamily: 'skybori',
                  fontSize: 20,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: detailController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText:
                      '신뢰할 수 있는 거래를 위해 자세히 적어주세요. \n(판매금지 물품은 게시가 제한될 수 있어요)\n\n서경대 학생들의 안전한 중고거래 환경을 위해\n함께 노력해주세요)',
                  hintStyle: TextStyle(color: Color(0xffC0C0C0), fontFamily: 'mitmi'),
                  filled: true,
                  fillColor: Color(0xffF8FFF2),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Color(0xffD0E4BC)),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 20.0),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 70,
                child: GreenButton(
                  text1: '작성하기',
                  width: 756,
                  height: 50,
                  onPressed: uploadData,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
