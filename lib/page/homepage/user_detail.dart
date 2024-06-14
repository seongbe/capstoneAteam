import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UserDetail extends StatefulWidget {
  final String uid;

  const UserDetail({Key? key, required this.uid}) : super(key: key);

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  late String nickname = '';
  late String department = '';
  late String profileImageUrl = '';
  late int popular = 0;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('User')
          .doc(widget.uid)
          .get();

      if (userDoc.exists) {
        var userData = userDoc.data() as Map<String, dynamic>;

        String fetchedNickname = userData['nickname'] ?? 'N/A';
        String fetchedProfileImageUrl = userData['profile_url'] ?? '';
        String fetchedDepartment = userData['department'] ?? 'N/A';
        int fetchedPopular = userData['popular'] ?? 'N/A';

        setState(() {
          nickname = fetchedNickname;
          department = fetchedDepartment;
          profileImageUrl = fetchedProfileImageUrl;
          popular = fetchedPopular;
        });
      } else {
        print('No user data found for uid: ${widget.uid}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '유저 페이지',
          style: TextStyle(fontFamily: 'skybori', fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            // 프로필 이미지 추가
            Center(
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffD0E4BC),
                  border: Border.all(
                    color: Color(0xffD0E4BC),
                    width: 0.5,
                  ),
                ),
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: profileImageUrl.isNotEmpty
                      ? NetworkImage(profileImageUrl)
                      : null,
                  backgroundColor: Colors.grey[200],
                ),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Text(
                nickname,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'skybori',
                  color: Color(0xFF464646),
                ),
              ),
            ),
            Divider(
              height: 50.0,
              color: Color(0xffD0E4BC),
              thickness: 1.0,
              indent: 30.0,
              endIndent: 30.0,
            ),
            SizedBox(height: 10),
            UserDataWidget(
              department: department,
              popular: popular,
            ),
            SizedBox(height: 10),
            Divider(
              height: 50.0,
              color: Color(0xffD0E4BC),
              thickness: 1.0,
              indent: 30.0,
              endIndent: 30.0,
            ),
            UserItemWidget(
              uid: widget.uid,
            ),
          ],
        ),
      ),
    );
  }
}

class UserItemWidget extends StatelessWidget {
  final String uid;

  const UserItemWidget({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Product')
          .where('user_id', isEqualTo: uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('에러 발생: ${snapshot.error}'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text('해당 사용자의 제품이 없습니다.'),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var product = snapshot.data!.docs[index];
              String title = product['title'];
              String description = product['description'];
              List<dynamic>? imageUrls = product['image_url'];


              String imageUrl = ''; // 이미지 URL 초기화
              if (imageUrls != null && imageUrls.isNotEmpty) {
                imageUrl = imageUrls[0]; // 첫 번째 이미지 URL 가져오기
              }

              return GestureDetector(
                onTap: () {
                  //아직 어떻게 구현해야할 지 생각 중
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0x26E1F0D3),
                    border: Border.all(
                      color: Color(0xFFE1F0D3),
                      width: 2,
                    ),
                  ),
                  child: ListTile(
                    leading: imageUrl.isNotEmpty
                        ? Image.network(
                      imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                        : Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey[300],
                      child: Icon(Icons.image),
                    ),
                    title: Text(title),
                    subtitle: Text(
                      description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
class UserDataWidget extends StatelessWidget {
  final String department;
  final int popular;

  const UserDataWidget({
    Key? key,
    required this.department,
    required this.popular,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserInfoRow(label: '학과 ', value: department),
          SizedBox(height: 10),
          UserInfoRow(label: '인기도 ', value: popular.toString()),
        ],
      ),
    );
  }
}

class UserInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const UserInfoRow({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'skybori',
              color: Color(0xFF464646),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'skybori',
                color: Color(0xFF464646),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
