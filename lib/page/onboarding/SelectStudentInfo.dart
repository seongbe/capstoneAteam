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

  List<String> departments = [
    'LF_라이프스타일디자인',
    'VD_비주얼디자인',
    '경영학과',
    '경영학부',
    '경제학과 (폐지)',
    '경찰행정전공',
    '공공인재전공',
    '공공인재학부',
    '공공인적자원학과(사회과학대학) (폐지)',
    '공공인적자원학부 (폐지)',
    '공공인적자원학부(사회과학대학) (폐지)',
    '공연예술학부',
    '공연예술학부(예술대학) (폐지)',
    '관현악전공',
    '광고홍보콘텐츠학과',
    '교양과정부 (폐지)',
    '국어국문학과 (폐지)',
    '국제비즈니스어학부 (폐지)'
    '군사학과',
    '글로벌경영학과 (폐지)',
    '글로벌비즈니스어학부',
    '금융경제학과 (폐지)',
    '금융경제학과(사회과학대학) (폐지)',
    '금융정보공학과(이공대학)',
    '기타모집단위',
    '나노융합공학과 (폐지)',
    '나노화학생명공학과',
    '도시공학과',
    '디자인학부',
    '디자인학부(문화산업공예디자인전공) (폐지)',
    '디자인학부(비주얼콘텐츠디자인전공) (폐지)',
    '메이크업디자인학과',
    '모델연기전공',
    '무대기술전공',
    '무대예술전공 (폐지)',
    '무대패션전공',
    '무용예술학과 (폐지)',
    '무용예술학부',
    '문화콘텐츠학과(인문과학대학) (폐지)',
    '문화콘텐츠학부(인문과학대학) (폐지)',
    '물류시스템공학과',
    '물류유통경영학과',
    '뮤지컬전공',
    '뮤지컬학과 (폐지)',
    '미용예술학과',
    '미용전공 (폐지)',
    '미용패션학부 (폐지)',
    '법학과 (폐지)',
    '뷰티테라피 & 메이크업 전공 (폐지)',
    '뷰티테라피 & 메이크업학과',
    '산업경영시스템공학과 (폐지)',
    '산업공학과 (폐지)',
    '생물공학과 (폐지)',
    '생활문화디자인전공 (폐지)',
    '성악전공 (폐지)',
    '소프트웨어학과',
    '수리정보통계학부 (폐지)',
    '스포츠앤테크놀로지학과',
    '시각정보디자인전공 (폐지)',
    '실용무용전공 (폐지)',
    '실용음악학과 (폐지)',
    '실용음악학부',
    '아동학과',
    '아트앤테크놀로지학과',
    '연극영화학부 (폐지)',
    '연기전공',
    '연출전공',
    '영어학과 (폐지)',
    '영화영상전공 (폐지)',
    '영화영상학과',
    '영화전공 (폐지)',
    '유럽어학부 (폐지)',
    '융합대학',
    '음악학부',
    '응용화학과 (폐지)',
    '인성교양대학',
    '인터넷정보학과 (폐지)',
    '일어학과 (폐지)',
    '재즈전공 (폐지)',
    '전자공학과 (폐지)',
    '전자상거래학과 (폐지)',
    '전자컴퓨터공학과',
    '정보통신공학과 (폐지)',
    '중어학과 (폐지)',
    '철학과 (폐지)',
    '컴퓨터공학과 (폐지)',
    '컴퓨터과학과 (폐지)',
    '토목건축공학과',
    '토목공학과 (폐지)',
    '패션전공 (폐지)',
    '프랜차이즈학과 (폐지)',
    '피아노전공',
    '한국무용전공 (폐지)',
    '행정학과 (폐지)',
    '헤어･메이크업 디자인 전공 (폐지)',
    '헤어･메이크업 디자인학과 (폐지)',
    '헤어디자인학과',
    '화학생명공학과 (폐지)',
    '화학생명공학부 (폐지)',
    //학과 추가
  ];
  String? selectedDepartment;

  @override
  void initState() {
    super.initState();
    email = widget.email;
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
                      showSelectedItems: true,
                    ),
                    items: departments,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        //labelText: "Menu mode",
                        hintText: "학과를 선택하세요",
                      ),
                    ),
                    selectedItem: selectedDepartment,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDepartment = newValue;
                      });
                    },
                  )
                  // child: DropdownSearch<String>(
                  //   mode: Mode.BOTTOM_SHEET,
                  //   showSearchBox: true,
                  //   items: departments,
                  //   label: "학과를 선택하세요",
                  //   selectedItem: selectedDepartment,
                  //   popupItemDisabled: (String item) => item.startsWith('Disabled'),
                  //   onChanged: (String? newValue) {
                  //     setState(() {
                  //       selectedDepartment = newValue;
                  //     });
                  //   },
                  // ),
                  ),
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
