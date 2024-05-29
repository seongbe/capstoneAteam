import 'dart:io';
import 'package:capstone/component/button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SetProfileImage extends StatefulWidget {
  const SetProfileImage({super.key});
  @override
  State<SetProfileImage> createState() => _SetProfileImageState();
}

class _SetProfileImageState extends State<SetProfileImage> {
  XFile? _pickedFile;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadImage() async {
    if (_pickedFile != null) {
      final now = DateTime.now();
      var ref = storage.ref().child('profileImages/$now.jpg');
      await ref.putFile(File(_pickedFile!.path));
    } else {
      if (kDebugMode) {
        print('No image selected');
      }
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
          )),
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
          children: [
            const SizedBox(height: 50,),
              Stack(
              children: [
              Positioned(right: 70, top: 100,
              child: IconButton(
                highlightColor: Colors.white,
                icon: Icon(Icons.camera_alt_outlined, color: Colors.black45, size: 40,),
                onPressed: () {
                  _showBottomSheet();
                },
              ),
              ),
              if(_pickedFile == null)
                Center(
                child: Container(
                  width: imageSize,
                  height: imageSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        width: 2, color: Colors.black12,),
                    image: DecorationImage(
                      image: AssetImage('assets/images/skon_fly.png'),
                      fit: BoxFit.cover),
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
                    border: Border.all(
                        width: 2, color: Colors.black12,),
                    image: DecorationImage(
                        image: FileImage(File(_pickedFile!.path)),
                        fit: BoxFit.cover),
                  ),
                ),
                ),
          ],),
              
            SizedBox(height: 50,),
            Text(
            '닉네임',
            style: TextStyle(
              fontFamily: 'skybori',
              fontSize: 20,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(height: 10,),
          TextField(
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
          SizedBox(
            height: 40.0,
          ),
          GreenButton(
            text1: '프로필수정',
            width: 756,
            height: 50,
            onPressed: () {
              uploadImage();
              //CustomDialog.showAlert(
              //  context, "프로필 수정이 완료되었습니다.", 20, Colors.black,);
            },
            letterspace: 30,
          ),
        ],),
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
                onPressed: () {_getCameraImage();},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffD0E4BC),
                  surfaceTintColor: Color(0xffD0E4BC),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(  
                    borderRadius: BorderRadius.circular(12),  
                  ),
                  fixedSize: Size(300, 60),
                ),
                child: const Text('사진찍기',
                style: TextStyle(
                  fontFamily: 'skybori',
                  fontSize: 20,
                  letterSpacing: 2.0,
                ),),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {_getPhotoLibraryImage();},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffD0E4BC),
                  surfaceTintColor: Color(0xffD0E4BC),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(  
                    borderRadius: BorderRadius.circular(12),  
                  ),
                  fixedSize: Size(300, 60),
                ),
                child: const Text('라이브러리에서 불러오기',
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
