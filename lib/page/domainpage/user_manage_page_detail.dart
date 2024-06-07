import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UserManagePageDetail extends StatefulWidget {
  final String userEmail;

  const UserManagePageDetail({Key? key, required this.userEmail})
      : super(key: key);

  @override
  _UserManagePageDetailState createState() => _UserManagePageDetailState();
}

class _UserManagePageDetailState extends State<UserManagePageDetail> {
  late String studentID = '';
  late String nickname = '';
  late bool accountStatus = false;
  late Timestamp createdAt = Timestamp.fromDate(DateTime.now());
  late String profileImageUrl = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '유저 정보',
          style: TextStyle(fontFamily: 'skybori', fontSize: 24),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            // 프로필 이미지 추가
            Center(
              child: Container(
                padding: EdgeInsets.all(5), // 테두리의 두께를 조정합니다
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffD0E4BC), // 동그라미의 배경색과 동일하게 설정합니다
                  border: Border.all(
                    color: Color(0xffD0E4BC), // 테두리의 색상을 설정합니다
                    width: 0.5, // 테두리의 두께를 조정합니다
                  ),
                ),
                child: CircleAvatar(
                  radius: 120,
                  backgroundImage: profileImageUrl.isNotEmpty
                      ? NetworkImage(profileImageUrl)
                      : null,
                  backgroundColor: Colors.grey[200],
                ),
              ),
            ),
            SizedBox(height: 80),
            // 상태를 사용하는 위젯을 빌드 메서드에 추가
            UserDataWidget(
              studentID: studentID,
              nickname: nickname,
              accountStatus: accountStatus,
              createdAt: createdAt,
              userEmail: widget.userEmail,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchUserData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('User')
          .where('user_id', isEqualTo: widget.userEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;

        String fetchedStudentID = userData['StudentID'] ?? 'N/A';
        String fetchedNickname = userData['nickname'] ?? 'N/A';
        bool fetchedAccountStatus = userData['status'] ?? false;
        Timestamp fetchedCreatedAt = userData['created_at'] ?? Timestamp.now();
        String fetchedProfileImageUrl = userData['profile_url'] ?? '';

        setState(() {
          studentID = fetchedStudentID;
          nickname = fetchedNickname;
          accountStatus = fetchedAccountStatus;
          createdAt = fetchedCreatedAt;
          profileImageUrl = fetchedProfileImageUrl;
        });
      } else {
        print('No user data found for user with email: ${widget.userEmail}');
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
}

// 상태를 사용하는 위젯을 별도의 StatefulWidget으로 분리
class UserDataWidget extends StatefulWidget {
  final String studentID;
  final String nickname;
  final bool accountStatus;
  final Timestamp createdAt;
  final String userEmail;

  const UserDataWidget({
    Key? key,
    required this.studentID,
    required this.nickname,
    required this.accountStatus,
    required this.createdAt,
    required this.userEmail,
  }) : super(key: key);

  @override
  _UserDataWidgetState createState() => _UserDataWidgetState();
}

class _UserDataWidgetState extends State<UserDataWidget> {
  @override
  Widget build(BuildContext context) {
    String formattedCreatedAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(widget.createdAt.toDate());

    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 20),
            Text(
              '학번: ',
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'skybori',
                  color: Color(0xFF464646)),
            ),
            SizedBox(width: 10),
            Text(
              '${widget.studentID}',
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'skybori',
                  color: Color(0xFF464646)),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            SizedBox(width: 20),
            Text(
              '닉네임: ',
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'skybori',
                  color: Color(0xFF464646)),
            ),
            SizedBox(width: 10),
            Text(
              '${widget.nickname}',
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'skybori',
                  color: Color(0xFF464646)),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            SizedBox(width: 20),
            Text(
              '이메일: ',
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'skybori',
                  color: Color(0xFF464646)),
            ),
            SizedBox(width: 10),
            Text(
              '${widget.userEmail}',
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'skybori',
                  color: Color(0xFF464646)),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            SizedBox(width: 20),
            Text(
              '계정 상태: ',
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'skybori',
                  color: Color(0xFF464646)),
            ),
            SizedBox(width: 10),
            Text(
              '${widget.accountStatus ? '활성화' : '정지'}',
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'skybori',
                  color: Color(0xFF464646)),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            SizedBox(width: 20),
            Text(
              '계정 생성일시: ',
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'skybori',
                  color: Color(0xFF464646)),
            ),
            SizedBox(width: 10),
            Text(
              '$formattedCreatedAt',
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'skybori',
                  color: Color(0xFF464646)),
            ),
          ],
        ),
      ],
    );
  }
}
