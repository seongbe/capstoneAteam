import 'package:flutter/material.dart';

class SelectedImage extends StatelessWidget {
  const SelectedImage({super.key});

  @override
  Widget build(BuildContext context) {
    return _selectedImage();
  }
}

Widget _selectedImage() {
  return Container(
    width: 110,
    height: 110,
    color: Colors.black,
    child: const Center(
      child: Icon(
        // 선택 안되면 보여줄 아이콘부분
        Icons.image_not_supported,
        color: Colors.white,
        size: 100,
      ),
    ),
  );
}
