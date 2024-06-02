import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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

  void clearImages() {
    pickedImages.clear();
  }
  
}