import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:capstone/page/domainpage/contact_page_wait.dart';
import 'package:capstone/page/domainpage/contact_page_end.dart';
import 'package:capstone/page/domainpage/Domainpage.dart';


class UserManagePage extends StatefulWidget {
  const UserManagePage({Key? key}) : super(key: key);

  @override
  _UserManagePageState createState() => _UserManagePageState();
}

class _UserManagePageState extends State<UserManagePage> {
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
                          _buildHeaderItem('  ID(학번) '),
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
                  // _buildUserInfoTile을 호출하여 위젯 생성 후 반환
                  if (index % 3 == 0) {
                    return _buildUserInfoTile(
                      name: '김민서',
                      id: '2021301010',
                      accountStatus: '활성화',
                    );
                  } else if (index % 3 == 1) {
                    return _buildUserInfoTile(
                      name: '김가은',
                      id: '2020301000',
                      accountStatus: '활성화',
                    );
                  } else {
                    return _buildUserInfoTile(
                      name: '김서경',
                      id: '2024301000',
                      accountStatus: '정지',
                    );
                  }
                },
                childCount: 16, // 예시로 10개의 항목 생성
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
                _buildUserInfoItem(name),
              ],
            ),
          ),
          Expanded(child: _buildUserInfoItem(id)),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildUserInfoItem(accountStatus),
                IconButton(
                  icon: Image.asset('assets/icons/icon_more.png'),
                  onPressed: () {
                    String alertMessage = accountStatus == '활성화'
                        ? "해당 사용자를 \n정지하시겠습니까?"
                        : "해당 사용자를 \n활성화하시겠습니까?";
                    CustomDialog3.showAlert(context, alertMessage, 14, Colors.black);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfoItem(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'skybori',
        fontSize: 18,
        color: Color(0xFF464646),
      ),
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
            labelText: '이름 또는 학번을 검색하세요.',
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

class CustomDialog3 {
  static void showAlert(
      BuildContext context, String message, double fontSize, Color textColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 20,
            ),
            AlertDialog(
              backgroundColor: Color(0xFFCFE4BC),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      message,
                      style: TextStyle(
                        color: textColor,
                        fontFamily: 'mitmi',
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              actions: [], // actions 비우기
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // 확인 버튼을 눌렀을 때 수행할 작업 추가
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF78BE39), // 버튼의 배경색
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(50), // 버튼의 모서리를 둥글게 만듭니다.
                      side: BorderSide(
                          width: 1.50, color: Color(0xFF65AA28)), // 버튼의 테두리 설정
                    ),
                  ),
                  child: Text('확인',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontFamily: 'mitmi',
                        fontWeight: FontWeight.w400,
                        height: 0.03,
                        letterSpacing: 9.45,
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    // 확인 버튼을 눌렀을 때 수행할 작업 추가
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF78BE39), // 버튼의 배경색
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(50), // 버튼의 모서리를 둥글게 만듭니다.
                      side: BorderSide(
                          width: 1.50, color: Color(0xFF65AA28)), // 버튼의 테두리 설정
                    ),
                  ),
                  child: Text('취소',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontFamily: 'mitmi',
                        fontWeight: FontWeight.w400,
                        height: 0.03,
                        letterSpacing: 9.45,
                      )),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(home: UserManagePage()));
}
