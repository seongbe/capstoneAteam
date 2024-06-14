import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../component/ImagePickerScreen.dart';
import '../../component/button.dart';
import '../../controller/imagePickerController.dart';
import '../../component/alerdialog.dart';
import '../../component/alterdilog2.dart';
import '../homepage/homePage.dart';

class ReWritePage extends StatefulWidget {
  final Map<String, dynamic>? product;

  const ReWritePage({this.product});

  @override
  State<ReWritePage> createState() => _ReWritePageState();
}

class _ReWritePageState extends State<ReWritePage> {
  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late ImagePickerController imageController = Get.put(ImagePickerController());

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.product!['title']);
    _priceController = TextEditingController(text: widget.product!['price']);
    _descriptionController = TextEditingController(text: widget.product!['description']);
    imageController.loadInitialImages(List<String>.from(widget.product!['image_url'] ?? []));
  }

  Future<void> _updateProduct() async {
    if (_titleController.text.isEmpty || _priceController.text.isEmpty || _descriptionController.text.isEmpty) {
      CustomDialog2.showAlert(
        context,
        '모든 필드를 입력해주세요.',
        14,
        Colors.black,
      );
      return;
    }

    try {
      final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

      // 이미지 업로드
      List<String> imageUrls = await imageController.uploadImages();

      await FirebaseFirestore.instance.collection('Product').doc(widget.product!['post_id']).update({
        'title': _titleController.text,
        'price': _priceController.text,
        'description': _descriptionController.text,
        'image_url': imageUrls,
      });

      CustomDialog.showAlert(
        context,
        '수정이 완료되었습니다.',
        18.0,
        Colors.black,
        () {
          Get.to(() => HomePage(2));
        },
      );
    } catch (error) {
      print('Error updating product: $error');
      CustomDialog2.showAlert(
        context,
        '오류가 발생했습니다.',
        14,
        Colors.black,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '수정하기',
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
        )),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
        children: [
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
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _titleController,
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
              SizedBox(
                height: 20.0,
              ),
              Text(
                '가격',
                style: TextStyle(
                  fontFamily: 'skybori',
                  fontSize: 20,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  hintText: '가격을 입력하세요.',
                  hintStyle: TextStyle(color: Color(0xffC0C0C0), fontFamily: 'mitmi'),
                  filled: true,
                  fillColor: Color(0xffF8FFF2),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Color(0xffD0E4BC)),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                '자세한 설명',
                style: TextStyle(
                  fontFamily: 'skybori',
                  fontSize: 20,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: '내용을 입력하세요.',
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
                  text1: '수정하기',
                  width: 756,
                  height: 50,
                  onPressed: _updateProduct,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
