import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:capstone/component/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capstone/component/alerdialog.dart';
import 'package:capstone/page/onboarding/createAccount.dart';
import 'package:dropdown_search/dropdown_search.dart';

class Selectstudentinfo extends StatefulWidget {
  final User? user;
  final String email;

  Selectstudentinfo({Key? key, required this.user, required this.email})
      : super(key: key);

  @override
  _SelectstudentinfoState createState() => _SelectstudentinfoState();
}

class _SelectstudentinfoState extends State<Selectstudentinfo> {
  final TextEditingController _studentIdController = TextEditingController();
  late String email;

  List<String> department = [];
  String? selectedDepartment;

  @override
  void initState() {
    super.initState();
    email = widget.email;
    fetchDepartments();
  }

  Future<void> fetchDepartments() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('department').get();
      List<String> deptList = snapshot.docs.map((doc) => doc.id).toList(); // 학과 이름을 문서 ID로 사용
      setState(() {
        department = deptList;
      });
    } catch (e) {
      print('Error fetching department: $e');
      CustomDialog.showAlert(
        context,
        "학과 목록을 불러오는 중 오류가 발생했습니다.",
        20,
        Colors.black,
            () {},
      );
    }
  }

  Future<void> deleteUser() async {
    if (widget.user != null) {
      try {
        await widget.user!.delete();
      } catch (e) {
        print('사용자 삭제 중 오류 발생: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '회원가입',
          style: TextStyle(
            fontSize: 40,
            color: Colors.black,
            fontFamily: 'mitmi',
          ),
        ),
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            deleteUser();
            Get.back();
          },
        ),
        actions: [
          Image.asset('assets/images/skon_fly.png'),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 35),
                  Text(
                    '학번',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SKYBORI',
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: _studentIdController,
                  decoration: InputDecoration(
                    labelText: '학번을 입력하세요',
                    labelStyle: TextStyle(
                      color: Color(0xffC0C0C0),
                      fontFamily: 'mitmi',
                    ),
                    filled: true,
                    fillColor: Color(0xffF8FFF2),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Color(0xffD0E4BC),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(width: 35),
                  Text(
                    '학과',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SKYBORI',
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                  width: 350,
                  child: DropdownSearch<String>(
                    popupProps: PopupProps.menu(
                      showSearchBox: true,
                      showSelectedItems: true,
                      itemBuilder: (context, item, isSelected) {
                        return Column(
                          children: [
                            Container(
                              color: isSelected
                                  ? Color(0xffF8FFF2)
                                  : Colors.white, // 배경 색 설정
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      item,
                                      style: TextStyle(
                                        color: Colors.black, // 텍스트 색상
                                        fontFamily: 'mitmi', // 원하는 글씨체로 변경
                                      ),
                                    ),
                                  ),
                                  Divider(color: Colors.grey), // 항목 사이의 구분선
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    items: department,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        hintText: "학과를 선택하세요",
                        hintStyle: TextStyle(
                          color: Color(0xffC0C0C0),
                          fontFamily: 'mitmi',
                        ),
                        filled: true,
                        fillColor: Color(0xffF8FFF2),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xffD0E4BC),
                          ),
                        ),
                      ),
                    ),
                    selectedItem: selectedDepartment,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDepartment = newValue;
                      });
                    },
                  )),
              SizedBox(height: 20),
              GreenButton(
                text1: '다음',
                width: 100,
                height: 50,
                onPressed: () async {
                  if (_studentIdController.text.trim().isEmpty) {
                    CustomDialog.showAlert(
                      context,
                      "학번을 입력해주세요.",
                      20,
                      Colors.black,
                      () {},
                    );
                    return;
                  }

                  if (_studentIdController.text.trim().length != 10) {
                    CustomDialog.showAlert(
                      context,
                      "학번을 제대로 입력해주세요.",
                      20,
                      Colors.black,
                          () {},
                    );
                    return;
                  }

                  if (selectedDepartment == null) {
                    CustomDialog.showAlert(
                      context,
                      "학과를 선택해주세요.",
                      20,
                      Colors.black,
                      () {},
                    );
                    return;
                  }

                  String studentId = _studentIdController.text.trim();
                  String department = selectedDepartment ?? '';

                  Get.off(() => CreatAccount(
                        user: widget.user,
                        email: widget.email,
                        studentId: studentId,
                        department: department,
                      ));
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
