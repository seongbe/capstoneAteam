import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:capstone/page/domainpage/contact_page_wait.dart';
import 'package:capstone/page/domainpage/contact_page_end.dart';
import 'package:capstone/page/domainpage/Domainpage.dart';

class UserManagePage extends StatelessWidget {
  const UserManagePage({Key? key});

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
                    // 계정상태 변경 팝업창
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


void main() {
  runApp(MaterialApp(home: UserManagePage()));
}
