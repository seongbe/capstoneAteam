import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Container(child: Text('로그인페이지임')),
      ),
    );
  }
}
