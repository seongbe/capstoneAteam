import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capstone/page/domainpage/Domainpage.dart';
import 'dart:async';
import 'dart:ui' as ui;
import '../../component/alterdilog3.dart';
import '../../component/alerdialog.dart';

class UserManagePage extends StatefulWidget {
  const UserManagePage({Key? key}) : super(key: key);

  @override
  _UserManagePageState createState() => _UserManagePageState();
}

class _UserManagePageState extends State<UserManagePage> {
  late List<Map<String, dynamic>> userDataList = [];

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('UserDomainTest').get();
      List<Map<String, dynamic>> tempList = [];

      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> userData = {
          'name': doc['nickname'],
          'id': doc['user_id'],
          'accountStatus': doc['status'] ? '활성화' : '정지',
        };
        tempList.add(userData);
      });

      setState(() {
        userDataList = tempList;
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Image.asset('assets/icons/icon_back.png'),
            onPressed: () {
              Get.to(DomainPage());
            },
          ),
          title: Center(
            child: Text(
              '사용자 관리        ',
              style: TextStyle(
                fontFamily: 'skybori',
                fontSize: 30,
                color: Color(0xFF464646),
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Divider(
              color: Color(0xFFCCCCCC),
              thickness: 1.0,
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: _SearchHeaderDelegate(),
            ),
            SliverAppBar(
              pinned: true,
              backgroundColor: Color(0xFFFFFFFF),
              flexibleSpace: Container(
                color: Color(0xFFFFFFFF),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildHeaderItem('  이름   '),
                          _buildHeaderItem('|'),
                          _buildHeaderItem('  ID(학교이메일) '),
                          _buildHeaderItem('|'),
                          _buildHeaderItem('계정 상태'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return _buildUserInfoTile(
                    name: userDataList[index]['name'],
                    id: userDataList[index]['id'],
                    accountStatus: userDataList[index]['accountStatus'],
                  );
                },
                childCount: userDataList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderItem(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'skybori',
        fontSize: 20,
        color: Color(0xFF464646),
      ),
    );
  }

  Widget _buildUserInfoTile(
      {required String name, required String id, required String accountStatus}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(width: 27),
                _buildUserInfoItem(name, 4), // 이름은 4글자까지 표시
              ],
            ),
          ),
          Expanded(child: _buildUserInfoItem(id, 8)), // ID는 8글자까지 표시
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildUserInfoItem(accountStatus, 8), // 계정 상태는 8글자까지 표시
                IconButton(
                  icon: Image.asset('assets/icons/icon_more.png'),
                  onPressed: () {
                    String action = accountStatus == '활성화' ? '정지' : '활성화';
                    String alertMessage = '해당 사용자를 \n$action 하시겠습니까?';
                    CustomDialog3.showConfirmationDialog(context, alertMessage.replaceFirst('해당 사용자', name), () async {
                      try {
                        // Firestore에서 사용자 문서의 UID를 가져오는 쿼리
                        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('UserDomainTest')
                            .where('nickname', isEqualTo: name)
                            .where('user_id', isEqualTo: id)
                            .get()
                            .then((querySnapshot) => querySnapshot.docs.first);

                        // 사용자의 UID 가져오기
                        String userID = userSnapshot.id;

                        // Firestore에서 해당 사용자의 계정 상태 업데이트
                        await FirebaseFirestore.instance.collection('UserDomainTest')
                            .doc(userID)
                            .update({'status': accountStatus == '활성화' ? false : true});

                        // 다이얼로그 닫기
                        Navigator.of(context).pop();

                        String updatedStatus = accountStatus == '활성화' ? '정지' : '활성화';
                        CustomDialog.showAlert(
                          context,
                          '$name의 계정이\n $updatedStatus 되었습니다.',
                          25,
                          Colors.black,
                              () async {
                            // 팝업이 닫힌 후 추가로 수행할 작업 (필요한 경우)
                          },
                        );

                        // 데이터 새로 고침
                        await fetchUserData();

                      } catch (e) {
                        print('Error updating account status: $e');
                        // 업데이트 오류가 발생한 경우 사용자에게 알림을 표시할 수 있습니다.
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('계정 상태를 업데이트하는 도중 오류가 발생했습니다.'),
                        ));
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoItem(String text, int maxLength) {
    return Text(
      text.length <= maxLength ? text : text.substring(0, maxLength) + '...',
      style: TextStyle(
        fontFamily: 'skybori',
        fontSize: 18,
        color: Color(0xFF464646),
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _SearchHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: SizedBox(
        height: 80,
        child: TextField(
          decoration: InputDecoration(
            labelText: '이름 또는 ID를 검색하세요.',
            labelStyle: TextStyle(
              color: Color(0xffC0C0C0),
              fontFamily: 'mitmi',
            ),
            filled: true,
            fillColor: Color(0xffF8FFF2),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(width: 1, color: Color(0xffD0E4BC)),
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

void main() {
  runApp(MaterialApp(home: UserManagePage()));
}
