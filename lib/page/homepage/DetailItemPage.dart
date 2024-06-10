import 'package:capstone/page/homepage/chatingchang.dart';
import 'package:capstone/wiget/chat_button.dart';
import 'package:capstone/wiget/slideImage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import '../../component/alerdialog.dart';
import '../../component/alertdialog_login.dart';

class DetailItemPage extends StatefulWidget {
  final Map<String, dynamic>? product;

  DetailItemPage({this.product});

  @override
  State<DetailItemPage> createState() => _DetailItemPageState();
}

class _DetailItemPageState extends State<DetailItemPage> {
  bool isLiked = false;
  int likeCount = 0;
  String? currentUserId;

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      likeCount = widget.product!['like_count'] ?? 0;
      _checkIfLiked();
      _getCurrentUser();
    }
  }

  Future<void> _getCurrentUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUserId = user.uid;
      });
    }
  }

  Future<void> _checkIfLiked() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('User').doc(user.uid).get();
      if (userSnapshot.exists) {
        List<dynamic> interests = userSnapshot['interests'] ?? [];
        setState(() {
          isLiked = interests.contains(widget.product!['post_id']);
        });
      }
    }
  }


  void _toggleHeart() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      CustomDialogLogin.showAlert(
        context,
        '좋아요 기능은\n로그인 후 이용가능합니다.',
        15.0,
        Color.fromRGBO(29, 29, 29, 1),
      );
      return;
    }

    if (currentUserId == widget.product?['user_id']) {
      CustomDialog.showAlert(
        context,
        '자신의 게시글에는 좋아요를 누를수 없습니다',
        20,
        Colors.black,
            () async {
          // 팝업이 닫힌 후 추가로 수행할 작업 (필요한 경우)
        },
      );
      return;
    }

    setState(() {
      isLiked = !isLiked;
      likeCount = isLiked ? likeCount + 1 : likeCount - 1;
    });

    await _updateLikeCount();
    await _toggleInterest(widget.product!['post_id']);
  }


  Future<void> _updateLikeCount() async {
    if (widget.product != null) {
      DocumentReference productRef = FirebaseFirestore.instance
          .collection('Product')
          .doc(widget.product!['post_id']);

      await productRef.update({'like_count': likeCount});
    }
  }

  Future<DocumentSnapshot> _getUserData(String uid) async {
    return await FirebaseFirestore.instance.collection('User').doc(uid).get();
  }

  Future<void> _toggleInterest(String postId) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final DocumentReference userRef = FirebaseFirestore.instance.collection('User').doc(user.uid);
    final DocumentSnapshot userSnapshot = await userRef.get();

    if (!userSnapshot.exists) {
      await userRef.set({'interests': []});
    }

    List<dynamic> interests = userSnapshot['interests'] ?? [];

    if (isLiked) {
      interests.add(postId);
    } else {
      interests.remove(postId);
    }

    await userRef.update({'interests': interests});
  }

  String _formatDate(String dateTimeString) {
    final DateTime dateTime = DateTime.parse(dateTimeString);
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final List<String> imgPaths = product != null && product['image_url'] != null
        ? List<String>.from(product['image_url'])
        : [];
    final String? uid = product?['user_id'];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text('상세페이지'),
      ),
      body: product == null
          ? Center(child: Text('상품 정보가 없습니다.'))
          : FutureBuilder<DocumentSnapshot>(
        future: _getUserData(uid!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('사용자 정보를 불러오는 중 오류가 발생했습니다.'));
          } else if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('사용자 정보가 없습니다.'));
          }

          final userDoc = snapshot.data!;
          final String nickname = userDoc['nickname'] ?? '닉네임 없음';
          final String department = userDoc['department'] ?? '학과 없음';

          return SafeArea(
            child: ListView(
              children: [
                if (imgPaths.length > 1)
                  ImageCarouselSlider(imgPaths: imgPaths)
                else if (imgPaths.length == 1)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(imgPaths[0]),
                  )
                else
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('이미지가 없습니다.'),
                  ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Image(
                      width: 46,
                      height: 45,
                      image: AssetImage('assets/images/skon_fly.png'),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(nickname, style: TextStyle(fontSize: 16)),
                        Text(department, style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Text(
                          product['title'],
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
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 20),
                        Text(
                          _formatDate(product['created_at']),
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
                    SizedBox(height: 30),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        SizedBox(
                          child: Text(
                            product['description'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 20),
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
                          '좋아요수: $likeCount',
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
                    SizedBox(height: 10),
                  ],
                ),
                Divider(),
                SizedBox(
                  width: 390,
                  height: 50,
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: _toggleHeart,
                        child: Image(
                          width: 46,
                          height: 25,
                          image: AssetImage(isLiked
                              ? 'assets/icons/img_2.png'
                              : 'assets/icons/img_1.png'),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['price'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 0.09,
                            ),
                          ),
                          SizedBox(height: 15),
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
                      SizedBox(width: 140),
                      ChatButton(
                        width: 80,
                        height: 34,
                        text1: '채팅하기',
                        textsize: 14,
                        onPressed: () {
                          if (FirebaseAuth.instance.currentUser == null) {
                            CustomDialogLogin.showAlert(
                              context,
                              '채팅기능은\n로그인 후 이용가능합니다.',
                              15.0,
                              Color.fromRGBO(29, 29, 29, 1),
                            );
                          } else {
                            Get.to(Chatingchang());
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}