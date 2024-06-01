import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:capstone/page/onboarding/startPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //플러터 코어 엔진 초기화
  await Firebase.initializeApp();

  runApp(SeongBeom());
}

class SeongBeom extends StatelessWidget {
  const SeongBeom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const StartPage();
  }
}
