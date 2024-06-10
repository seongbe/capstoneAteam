// lib/component/ImagePickerScreen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/imagePickerController.dart'; // 컨트롤러를 임포트

class ImagePickerScreen extends StatelessWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImagePickerController controller = Get.put(ImagePickerController());

    return Obx(() => _gridPhoto(controller));
  }

  Widget _gridPhoto(ImagePickerController controller) {
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
                _showBottomSheet(controller);
              },
            ),
            SizedBox(width: 10), // 간격 조절
            ...controller.pickedImages.map((e) => _gridPhotoItem(e!)).toList(),
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
                  final controller = Get.find<ImagePickerController>();
                  controller.pickedImages.remove(e);
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

  _showBottomSheet(ImagePickerController controller) {
    return showModalBottomSheet(
      context: Get.context!,
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
                  controller.getImageFromCamera();
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffD0E4BC),
                  surfaceTintColor: Color(0xffD0E4BC),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
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
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.getMultiImage();
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffD0E4BC),
                  surfaceTintColor: Color(0xffD0E4BC),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
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