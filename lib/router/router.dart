import 'package:capstone/page/domainpage/domainpage.dart';
import 'package:capstone/page/onboarding/loginPage.dart'; // 클래스 이름을 대문자로 변경
import 'package:capstone/page/onboarding/loginpage.dart';
import 'package:get/get.dart';
import 'package:capstone/page/homePage/homePage.dart'; // 클래스 이름을 대문자로 변경
import 'package:capstone/page/domainPage/domainPage.dart'; // 클래스 이름을 대문자로 변경
import 'package:capstone/page/domainPage/DomainPage.dart';
import 'package:capstone/page/domainPage/LoginPage.dart';

class Routes {
  static final routes = [
    GetPage(name: '/', page: () => HomePage()), // 경로 이름을 대문자로 변경
    GetPage(name: '/domain', page: () => DomainPage()), // 경로 이름을 대문자로 변경
    GetPage(name: '/login', page: () => LoginPage()), // 경로 이름을 대문자로 변경
  ];
}
