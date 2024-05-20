import 'package:capstone/page/domainpage/user_manage_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../component/button.dart';
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
            Row(
              children: [
                SizedBox(width: 20), // 왼쪽 여백 추가
                Text(
                  '이메일: ',
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'skybori',
                      color: Color(0xFF464646)), // 폰트 크기 조정
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
                SizedBox(width: 20), // 왼쪽 여백 추가
                Text(
                  '닉네임: ',
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'skybori',
                      color: Color(0xFF464646)),
                ),
                SizedBox(width: 10),
                Text(
                  '$nickname',
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
                SizedBox(width: 20), // 왼쪽 여백 추가
                Text(
                  '계정 상태: ',
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'skybori',
                      color: Color(0xFF464646)),
                ),
                SizedBox(width: 10),
                Text(
                  '${accountStatus ? '활성화' : '정지'}',
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
                SizedBox(width: 20), // 왼쪽 여백 추가
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
            SizedBox(height: 20),
            Center(
              child: GreenButton(
                text1: accountStatus ? '정지하기' : '활성화하기',
                width: 288,
                height: 55,
                onPressed: () {
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
                            CustomDialog.showAlert(
                              context,
                              '$nickname의 계정이\n$updatedStatus 되었습니다.',
                              25,
                              Colors.black,
                              () async {
                                Get.to(UserManagePage());
                              },
                            );
                            // 데이터 새로 고침
                            fetchUserData();
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> fetchUserData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('UserDomainTest')
          .where('user_id', isEqualTo: widget.userEmail)
          .get();

      // 가져온 데이터 사용하기
      if (querySnapshot.docs.isNotEmpty) {
        // 첫 번째 문서의 데이터 사용
        var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;

        // 사용자 정보 가져오기
        String fetchedNickname = userData['nickname'] ?? 'N/A';
        bool fetchedAccountStatus = userData['status'] ?? false;
        String fetchedCreatedAt = userData['created_at'] ?? 'N/A';

        // 계정 생성일시 문자열을 DateTime으로 파싱하고 포맷
        DateTime createdAtDateTime = DateTime.parse(fetchedCreatedAt);
        String formattedFetchedCreatedAt =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(createdAtDateTime);

        // 사용자 정보 업데이트 및 UI 업데이트
        setState(() {
          nickname = fetchedNickname;
          accountStatus = fetchedAccountStatus;
          formattedCreatedAt = formattedFetchedCreatedAt;
        });
      } else {
        // 사용자 데이터가 없을 경우에 대한 처리
        print('No user data found for user with email: ${widget.userEmail}');
      }
    } catch (e) {
      // 오류 처리
      print('Error fetching user data: $e');
    }
  }
}
