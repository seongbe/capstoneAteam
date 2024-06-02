import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile?> _pickedImages = [];
  XFile? _pickedFile;

  // 카메라, 갤러리에서 이미지 1개 불러오기
  // ImageSource.galley , ImageSource.camera
  void getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);

    setState(() {
      _pickedImages.add(image);
    });
  }

  // 이미지 여러개 불러오기
  void getMultiImage() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      setState(() {
        _pickedImages.addAll(images);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _gridPhoto();
  }

  Widget _gridPhoto() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      height: 100,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            IconButton(
              iconSize: 50,
              icon: Icon(Icons.camera_alt_rounded),
              color: Colors.grey,
              onPressed: () {
                _showBottomSheet();
              },
            ),
            SizedBox(width: 10), // 간격 조절
            ..._pickedImages.map((e) => _gridPhotoItem(e!)).toList(),
            SizedBox(width: 10), // 간격 조절
          ],
        ),
      ),
    );
  }

  Widget _gridPhotoItem(XFile e) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        width: 100, // 적절한 너비 설정
        height: 100, // 적절한 높이 설정
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.file(
                File(e.path),
                fit: BoxFit.cover,
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
                  getImage(ImageSource.camera);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffD0E4BC),
                  surfaceTintColor: Color(0xffD0E4BC),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  //fixedSize: Size(300, 60),
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
                  getMultiImage();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffD0E4BC),
                  surfaceTintColor: Color(0xffD0E4BC),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  //fixedSize: Size(300, 60),
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
}
