import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:capstone/page/onboarding/startPage.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
