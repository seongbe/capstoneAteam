import 'package:capstone/component/alerdialog.dart';
import 'package:capstone/component/alterdilog2.dart';
import 'package:capstone/component/alterdilog3.dart';
import 'package:capstone/component/button.dart';
import 'package:capstone/page/homepage/SetProfileImage.dart';
import 'package:capstone/page/homepage/mypage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';

class Setprofilepage extends StatelessWidget {
  const Setprofilepage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;
    // Container의 너비와 높이를 동일하게 설정합니다.
    final containerSize = screenWidth;
    return MaterialApp(
      title: 'Set_Profile_Page',
      debugShowCheckedModeBanner: false,
      home: Inputpass(),
    );
  }
}

class Inputpass extends StatelessWidget {
  const Inputpass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '프로필 수정',
          style: TextStyle(
            fontFamily: 'skybori',
            fontSize: 30,
            letterSpacing: 5.0,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          Image.asset('assets/images/skon_fly.png'),
          SizedBox(width: 20),
        ],
        shape: Border(
            bottom: BorderSide(
          color: Colors.grey,
          width: 0.8,
        )),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
        children: <Widget>[
          Container(
            height: 135,
            width: 280,
            margin: EdgeInsets.only(left: 30.0,top: 30.0, right: 30.0,bottom: 20.0),
            decoration: BoxDecoration(
              border: Border.all(width: 1.7, color: Color(0xffD0E4BC)),
              borderRadius: BorderRadius.circular(40),
              color: Color(0xffF8FFF2)
            ),
            child:  Center(
              child: Text(
              '본인 확인을 위해 \n비밀번호를 입력해주세요.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'skybori',
                fontSize: 20,
                letterSpacing: 2.0,
              ),
            ),)
          ),
          
          Text(
            '비밀번호',
            style: TextStyle(
              fontFamily: 'skybori',
              fontSize: 20,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: '비밀번호를 입력하세요.',
              helperText: "* 필수 입력값입니다.",
              helperStyle: 
                  TextStyle(color: Color(0xffC0C0C0), fontFamily: 'mitmi'),
              labelStyle:
                  TextStyle(color: Color(0xffC0C0C0), fontFamily: 'mitmi'),
              filled: true,
              fillColor: Color(0xffF8FFF2),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(width: 1, color: Color(0xffD0E4BC)),
              ),
            ),
            obscureText: true, //비밀번호 안 보이게
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '비밀번호를 입력해주세요.';
              }
              return null;
            },
          ),
          SizedBox(height: 20,),
          Text(
            '비밀번호 확인',
            style: TextStyle(
              fontFamily: 'skybori',
              fontSize: 20,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: '비밀번호를 다시 입력해 주세요.',
              helperText: "* 필수 입력값입니다.",
              helperStyle: 
                  TextStyle(color: Color(0xffC0C0C0), fontFamily: 'mitmi'),
              labelStyle:
                  TextStyle(color: Color(0xffC0C0C0), fontFamily: 'mitmi'),
              filled: true,
              fillColor: Color(0xffF8FFF2),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(width: 1, color: Color(0xffD0E4BC)),
              ),
            ),
          ),
          GreenButton(
            // 버튼 글씨 사이즈 수정해야함
            text1: '본인인증',
            width: 756,
            height: 50,
            onPressed: () {
              CustomDialog2.showAlert(
                  context, "비밀번호가 일치하지 않습니다. ", 14, Colors.black, );
              Get.to(SetProfileImage());    
            },
          ),
        ],
      ),
    );
  }
}

class SetProfile extends StatefulWidget {
  const SetProfile({super.key});

  @override
  State<SetProfile> createState() => _SetProfileState();
}

class _SetProfileState extends State<SetProfile> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
