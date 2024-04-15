import 'package:flutter/material.dart';

class MainPost extends StatelessWidget {
  const MainPost({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return SizedBox(
          height: 100,
          child: Row(
            children: [
              Image.asset(
                'assets/images/skunivLogo.png',
              ),
            ],
          ),
        );
      },
      itemCount: 10,
    );
  }
}
