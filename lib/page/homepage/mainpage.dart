import 'dart:io';
import 'dart:math';

import 'package:capstone/page/homepage/postwritepage.dart';
import 'package:capstone/wiget/BookListItem.dart';
import 'package:capstone/wiget/mainpost.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // final ImagePicker picker = ImagePicker();
  // File? selectedImage;
  // String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
  // final FirebaseStorage storage = FirebaseStorage.instance;
  // final FirebaseFirestore firebaseFirestore =
  //     FirebaseFirestore.instance; // Firestore 인스턴스 추가
  // String? imageUrl; // 다운로드 URL을 저장할 변수

  // Future<void> pickImageFromGallery() async {
  //   var image = await picker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     setState(() {
  //       selectedImage = File(image.path);
  //     });
  //   }
  // }

  // Future<void> uploadImage() async {
  //   if (selectedImage == null) return;

  //   try {
  //     final now = DateTime.now();
  //     var ref = storage.ref().child('Images/${now.toIso8601String()}.jpg');
  //     var uploadTask = ref.putFile(selectedImage!);

  //     final snapshot = await uploadTask.whenComplete(() => {});
  //     final url = await snapshot.ref.getDownloadURL();

  //     // Firestore에 URL 저장
  //     await firebaseFirestore.collection('Images').doc().set({
  //       'url': url,
  //       'uploaded_at': now,
  //     });

  //     setState(() {
  //       imageUrl = url; // 다운로드 URL을 상태로 설정
  //     });

  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('Image uploaded successfully')));
  //   } catch (e) {
  //     print('Error uploading image: $e');
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('Error uploading image')));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leadingWidth: 150,
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back(); // 뒤로 가기
                },
              ),
              SizedBox(
                width: 20,
              ),
              Text('최신순'),
              SizedBox(width: 5), // 아이콘과 텍스트 사이 여백 조절
              Image.asset('assets/icons/Expand Arrow.png') // 추가할 아이콘
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                // 맨 오른쪽에 위치한 첫 번째 아이콘의 클릭 이벤트 처리
              },
              icon: Icon(Icons.search), // 맨 오른쪽 첫 번째 아이콘
            ),
            IconButton(
              onPressed: () {
                // 맨 오른쪽에 위치한 두 번째 아이콘의 클릭 이벤트 처리
              },
              icon: Icon(Icons.notifications), // 맨 오른쪽 두 번째 아이콘
            ),
            IconButton(
              onPressed: () {
                // 맨 오른쪽에 위치한 세 번째 아이콘의 클릭 이벤트 처리
              },
              icon: Icon(Icons.settings), // 맨 오른쪽 세 번째 아이콘
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF78BE39),
          onPressed: () {
            Get.to(PostWritePage());
          },
          child: Icon(Icons.add),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('Book').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              final books = snapshot.data!.docs;

              return StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Images').snapshots(),
                builder: (context, imageSnapshot) {
                  if (imageSnapshot.hasError) {
                    return Center(child: Text('Error: ${imageSnapshot.error}'));
                  }
                  if (imageSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount: books.length,
                    itemBuilder: (context, index) {
                      final book = books[index];
                      return Column(
                        children: [
                          BookListItem(
                            imagePath: book['imagepath'], // 이미지 경로
                            title: book['title'], // 제목
                            subtitle1: book['subtitle1'], // 부제목1
                            subtitle2: book['subtitle2'], // 부제목2
                          ),
                          BookListItem(
                            imagePath: book['imagepath'], // 이미지 경로
                            title: book['title'], // 제목
                            subtitle1: book['subtitle1'], // 부제목1
                            subtitle2: book['subtitle2'], // 부제목2
                          ),
                          BookListItem(
                            imagePath: book['imagepath'], // 이미지 경로
                            title: book['title'], // 제목
                            subtitle1: book['subtitle1'], // 부제목1
                            subtitle2: book['subtitle2'], // 부제목2
                          ),
                          BookListItem(
                            imagePath: book['imagepath'], // 이미지 경로
                            title: book['title'], // 제목
                            subtitle1: book['subtitle1'], // 부제목1
                            subtitle2: book['subtitle2'], // 부제목2
                          ),
                          BookListItem(
                            imagePath: book['imagepath'], // 이미지 경로
                            title: book['title'], // 제목
                            subtitle1: book['subtitle1'], // 부제목1
                            subtitle2: book['subtitle2'], // 부제목2
                          ),
                          // selectedImage != null
                          //     ? Image.file(
                          //         selectedImage!,
                          //         width: 110,
                          //         height: 110,
                          //       )
                          //     : Container(
                          //         width: 110,
                          //         height: 110,
                          //         color: Colors.black,
                          //         child: const Center(
                          //           child: Icon(
                          //             // 선택 안되면 보여줄 아이콘부분
                          //             Icons.image_not_supported,
                          //             color: Colors.white,
                          //             size: 100,
                          //           ),
                          //         ),
                          //       ),
                          // ElevatedButton(
                          //   onPressed: pickImageFromGallery,
                          //   child: Text('Pick Image'),
                          // ),
                          // ElevatedButton(
                          //   onPressed: uploadImage,
                          //   child: Text('Upload Image'),
                          // ),
                          // StreamBuilder<QuerySnapshot>(
                          //     stream: firebaseFirestore
                          //         .collection('Images')
                          //         .snapshots(),
                          //     builder: (context, snapshot) {
                          //       return (snapshot.connectionState ==
                          //               ConnectionState.waiting)
                          //           ? const Center(
                          //               child: CircularProgressIndicator
                          //                   .adaptive(),
                          //             )
                          //           : GridView.builder(
                          //               shrinkWrap: true,
                          //               physics:
                          //                   const NeverScrollableScrollPhysics(),
                          //               gridDelegate:
                          //                   const SliverGridDelegateWithFixedCrossAxisCount(
                          //                       mainAxisSpacing: 5.0,
                          //                       crossAxisSpacing: 5.0,
                          //                       crossAxisCount: 3),
                          //               itemCount: snapshot.data!.docs.length,
                          //               itemBuilder: (context, index) {
                          //                 final url =
                          //                     snapshot.data!.docs[index]['url'];
                          //                 return Image.network(
                          //                   url,
                          //                   width: double.infinity,
                          //                   fit: BoxFit.cover,
                          //                 );
                          //               });
                          //     }),
                        ],
                      );
                    },
                  );
                },
              );
            }),
      ),
    );
  }
}
