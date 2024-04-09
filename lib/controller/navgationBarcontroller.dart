import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;

  void changePage(int index) {
    selectedIndex.value = index;
  }

  void goToHomePage() {
    selectedIndex.value = 0;
  }

  void goToChatPage() {
    selectedIndex.value = 1;
  }

  void goToMyPage() {
    selectedIndex.value = 2;
  }
}
