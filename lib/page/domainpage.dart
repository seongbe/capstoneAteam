import 'package:flutter/material.dart';

class domainPage extends StatelessWidget {
  const domainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Container(child: Text('관리자페이지임')),
      ),
    );
  }
}
