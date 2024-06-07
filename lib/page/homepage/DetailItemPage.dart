import 'package:capstone/page/homepage/chatingchang.dart';
import 'package:capstone/wiget/chat_button.dart';
import 'package:capstone/wiget/slideImage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../component/alertdialog_login.dart';

class DetailItemPage extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
 
   

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          // 뒤로가기 버튼 추가
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // 뒤로가기 버튼 클릭 시 현재 페이지를 pop하여 이전 페이지로 이동
              Get.back();
            },
          ),
          title: Text('상세페이지'), // 앱 바 제목 설정
        ),
      
        body: SafeArea(

          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('ProductDetail').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text('데이터 끌어오는거 실패해서 오류난거임'));
                }

                final products = snapshot.data!.docs;
                  

                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    
                 final List<String> imgPaths = [
                  product['imagepath']
    
                  ];
                   

                    return Column(
            children: [
              Column(
                children: [
                  ImageCarouselSlider(imgPaths: imgPaths),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Image(
                        width: 46,
                        height: 45,
                        image: AssetImage(
                          'assets/images/skon_fly.png',
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('풀잎이',
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.start),
                          Text('소프트웨어학과'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
           
                  Row(
                    children: [
                      SizedBox(width: 20,),
                      Text(
                        product['maintitle'],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'inter',
                          fontWeight: FontWeight.w700,
                          height: 0.09,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                      ),

                      Text(
                        product['subject'],
                        style: TextStyle(
                          color: Color(0xFF8C8C8C),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0.12,
                        ),
                      ),

                      SizedBox(
                        width: 10,
                      ),

                      Text(
                        product['day'],
                        style: TextStyle(
                          color: Color(0xFF8C8C8C),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0.12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                       SizedBox(
                    width: 20,
                  ),
                      SizedBox(
                        child: Text(
                        product['detail'],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        '관심  ',
                        style: TextStyle(
                          color: Color(0xFF8C8C8C),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0.12,
                        ),
                      ),
                      Text(
                        product['관심'],
                        style: TextStyle(
                          color: Color(0xFF8C8C8C),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0.12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
              Divider(),
              SizedBox(
                width: 390,
                height: 50,
                child: Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        Image(
                          width: 46,
                          height: 25,
                          image: AssetImage(
                            'assets/icons/icon_heart_fill.png',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Column 내부의 자식 위젯들을 수직으로 중앙 정렬
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '10,000원',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0.09,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          '가격 제안 불가',
                          style: TextStyle(
                            color: Color(0xFF8C8C8C),
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 0.12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 140,
                    ),
                    ChatButton(
                      width: 80,
                      height: 34,
                      text1: '채팅하기',
                      textsize: 14,
                      onPressed: () {
                        if (FirebaseAuth.instance.currentUser == null) {
                          CustomDialogLogin.showAlert(context, '채팅기능은\n로그인 후 이용가능합니다.', 15.0, Color.fromRGBO(29, 29, 29, 1));
                        }  else {
                          // 현재 사용자가 로그인되어 있는 경우, 채팅 페이지로 이동
                          Get.to(Chatingchang());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
                  }
        );
              }
      ),
        ),
      ),
    );
  }
}
