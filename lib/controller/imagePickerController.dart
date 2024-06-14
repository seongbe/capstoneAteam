import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ImagePickerController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final RxList<XFile?> pickedImages = <XFile?>[].obs;

  // 이미지 여러개 불러오기
  Future<void> getMultiImage() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      pickedImages.addAll(images);
    }
  }

  // 카메라로 사진 찍기
  Future<void> getImageFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      pickedImages.add(image);
    }
  }

  // 이미지 초기화
  void clearImages() {
    pickedImages.clear();
  }

  // 초기 이미지 URL 로드
  Future<void> loadInitialImages(List<String> urls) async {
    for (String url in urls) {
      pickedImages.add(XFile(url));
    }
  }

  // 이미지 업로드
  Future<List<String>> uploadImages() async {
    List<String> imageUrls = [];
    for (XFile? image in pickedImages) {
      if (image != null) {
        if (image.path.startsWith('http')) {
          imageUrls.add(image.path);
        } else {
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          Reference storageReference = FirebaseStorage.instance.ref().child('product/$fileName');
          UploadTask uploadTask = storageReference.putFile(File(image.path));
          TaskSnapshot taskSnapshot = await uploadTask;
          String url = await taskSnapshot.ref.getDownloadURL();
          imageUrls.add(url);
        }
      }
    }
    return imageUrls;
  }
}
