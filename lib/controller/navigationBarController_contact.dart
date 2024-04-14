import 'package:get/get.dart';

class ContactController extends GetxController {
  var selectedIndex = 0.obs;

  void changePage(int index) {
    selectedIndex.value = index;
  }

  void goToAll() {
    selectedIndex.value = 0;
  }

  void goToWait() {
    selectedIndex.value = 1;
  }

  void goToEnd() {
    selectedIndex.value = 2;
  }
}
