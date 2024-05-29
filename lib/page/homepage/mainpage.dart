import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String uid = FirebaseAuth.instance.currentUser!.uid;

  getUserInfo() async {
    var result =
        await FirebaseFirestore.instance.collection('userInfo').doc(uid).get();
    return result.data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getUserInfo(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text((snapshot.data as Map)['name']),
                        Text((snapshot.data as Map)['email']),
                        Text((snapshot.data as Map)['phoneNumber']),
                      ],
                    ),
                  )
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
