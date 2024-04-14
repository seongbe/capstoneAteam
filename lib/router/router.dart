import 'package:capstone/page/domainpage/Domainpage.dart';
import 'package:capstone/page/onboarding/loginpage.dart';

import 'package:get/get.dart';
import 'package:capstone/page/homePage/homePage.dart';

class Routes {
  static final routes = [
    GetPage(name: '/', page: () => HomePage()), // 경로 이름을 대문자로 변경
    GetPage(name: '/domain', page: () => DomainPage()), // 경로 이름을 대문자로 변경
    GetPage(name: '/login', page: () => loginpage()), // 경로 이름을 대문자로 변경
  ];
}
