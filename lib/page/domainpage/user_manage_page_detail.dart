import 'package:capstone/page/domainpage/user_manage_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../component/alterdilog3.dart';
import '../../component/alerdialog.dart';

class UserManagePageDetail extends StatefulWidget {
  final String userEmail;

  const UserManagePageDetail({Key? key, required this.userEmail})
      : super(key: key);

  @override
  _UserManagePageDetailState createState() => _UserManagePageDetailState();
}

class _UserManagePageDetailState extends State<UserManagePageDetail> {
  late String nickname = '';
  late bool accountStatus = false;
  late String formattedCreatedAt = '';
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
        title: Text('유저 정보',
            style: TextStyle(fontFamily: 'skybori', fontSize: 24)),
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
                      : AssetImage('assets/default_profile.png')

                          as ImageProvider,

                  backgroundColor: Colors.grey[200],
                ),
              ),
            ),

            SizedBox(height: 80),

            // 상태를 사용하는 위젯을 빌드 메서드에 추가
            UserDataWidget(
              nickname: nickname,
              accountStatus: accountStatus,
              formattedCreatedAt: formattedCreatedAt,
              userEmail: widget.userEmail,
              onPressed: _updateAccountStatus,
            ),
          ],
        ),
      ),
    );
  }

  // 상태 업데이트 함수
  void _updateAccountStatus() async {
    String action = accountStatus ? '정지' : '활성화';
    String alertMessage = '해당 사용자을(를)\n$action 하시겠습니까?';
    CustomDialog3.showConfirmationDialog(
      context,
      alertMessage.replaceFirst('해당 사용자', nickname),

      () async {

        try {
          await FirebaseFirestore.instance
              .collection('UserDomainTest')
              .where('user_id', isEqualTo: widget.userEmail)
              .get()
              .then((querySnapshot) {
            String docId = querySnapshot.docs.first.id;
            FirebaseFirestore.instance
                .collection('UserDomainTest')
                .doc(docId)
                .update({'status': !accountStatus}).then((_) {
              Navigator.of(context).pop();
              String updatedStatus = accountStatus ? '정지' : '활성화';
              setState(() {
                // 상태 업데이트 후에 Alert 메시지를 표시
                CustomDialog.showAlert(
                  context,
                  '$nickname의 계정이\n$updatedStatus 되었습니다.',
                  25,
                  Colors.black,

                  () async {

                    // 상태 업데이트 후에 UserManagePage로 이동
                    Get.to(UserManagePage());
                  },
                );
              });
            });
          });
        } catch (e) {
          print('Error updating account status: $e');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('계정 상태를 업데이트하는 도중 오류가 발생했습니다.'),
          ));
        }
      },
    );
  }

  Future<void> fetchUserData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('UserDomainTest')
          .where('user_id', isEqualTo: widget.userEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;

        String fetchedNickname = userData['nickname'] ?? 'N/A';
        bool fetchedAccountStatus = userData['status'] ?? false;
        String fetchedCreatedAt = userData['created_at'] ?? 'N/A';
        String fetchedProfileImageUrl = userData['profile_url'] ?? '';
        DateTime createdAtDateTime = DateTime.parse(fetchedCreatedAt);
        String formattedFetchedCreatedAt =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(createdAtDateTime);

        setState(() {
          nickname = fetchedNickname;
          accountStatus = fetchedAccountStatus;
          formattedCreatedAt = formattedFetchedCreatedAt;
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
  final String nickname;
  final bool accountStatus;
  final String formattedCreatedAt;
  final String userEmail;
  final VoidCallback onPressed;

  const UserDataWidget({
    Key? key,
    required this.nickname,
    required this.accountStatus,
    required this.formattedCreatedAt,
    required this.userEmail,
    required this.onPressed,
  }) : super(key: key);

  @override
  _UserDataWidgetState createState() => _UserDataWidgetState();
}

class _UserDataWidgetState extends State<UserDataWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
              '${widget.formattedCreatedAt}',
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'skybori',
                  color: Color(0xFF464646)),
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }

}