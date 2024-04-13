import 'package:flutter/material.dart';
import 'package:get/get.dart'; // GetX 패키지 가져오기

class AlertScreen extends StatelessWidget {
  final String text1;
  final VoidCallback? onPressed1;
  final VoidCallback? onPressed2;

  const AlertScreen({
    Key? key,
    required this.text1,
    required this.onPressed1,
    required this.onPressed2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog();
  }
}
