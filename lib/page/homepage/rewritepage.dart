import 'dart:io';
import 'package:capstone/component/button.dart';
import 'package:capstone/page/homepage/writelistpage.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ReWritePage extends StatefulWidget {
  const ReWritePage({super.key});

  @override
  State<ReWritePage> createState() => _ReWritePageState();
}

class _ReWritePageState extends State<ReWritePage> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile?> _pickedImages = [];
  XFile? _pickedFile;
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
      body: SafeArea(
        child: Padding(padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
        child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset('assets/images/book.jfif',
                      width: 100, height: 100, fit: BoxFit.contain),
                  SizedBox(height: 20),
                  _gridPhoto(),
                  IconButton(
                    style: IconButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 70,
                    ),
                    onPressed: () {
                      _showBottomSheet();
                    },
                  ),
                ],
              ),
              Divider(
                height: 50.0,
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
                decoration: InputDecoration(
                  labelText: '제목을 입력하세요.',
                  helperText: "* 필수 입력값입니다.",
                  labelStyle:
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
                decoration: InputDecoration(
                  labelText: '가격을 입력하세요.',
                  labelStyle:
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
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: '내용을 입력하세요.',
                  labelStyle:
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
                width: double.infinity,
                height: 70,
                child: GreenButton(
                  // 버튼 글씨 사이즈 수정해야함
                  text1: '수정하기',
                  width: 756,
                  height: 50,
                  onPressed: () {
                    Get.to(Writelistpage());
                  },
                ),
              )
            ],
        ),
          ),
      ),
    );
  }

  void getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);

    setState(() {
      _pickedImages.add(image);
    });
  }
  
  // 이미지 여러개 불러오기
  void getMultiImage() async {
    final List<XFile> images = await _picker.pickMultiImage();

    setState(() {
      _pickedImages.addAll(images);
    });
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
                onPressed: () {getImage(ImageSource.camera);},
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
                onPressed: () {getMultiImage();},
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

  Widget _gridPhoto() {
    return Expanded(
      child: _pickedImages.isNotEmpty
          ? GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              children: _pickedImages
                  .where((element) => element != null)
                  .map((e) => _gridPhotoItem(e!))
                  .toList(),
            )
          : const SizedBox(),
    );

  }

  Widget _gridPhotoItem(XFile e) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.file(
              File(e.path),
              fit: BoxFit.cover,
              height: 100,
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _pickedImages.remove(e);
                });
              },
              child: const Icon(
                Icons.cancel_rounded,
                color: Colors.black87,
              ),
            ),
          )
        ],
      ),
    );
  }

  
}