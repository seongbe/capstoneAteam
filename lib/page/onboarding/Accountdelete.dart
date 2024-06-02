import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// 사용자 계정을 삭제하는 함수
Future<void> deleteUser() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    try {
      // Firebase Authentication에서 사용자 계정 삭제
      await user.delete();

      // Firestore에서 사용자 정보 삭제
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference usersCollection = firestore.collection('User');
      await usersCollection.doc(user.uid).delete();

      // 기타 사용자와 관련된 데이터 삭제 작업 수행

      // 사용자에게 탈퇴가 완료되었음을 알리는 메시지 출력 등의 작업 수행
    } catch (e) {
      // 탈퇴 과정에서 오류가 발생한 경우 예외 처리
      print('사용자 탈퇴 중 오류 발생: $e');
      // 오류 메시지를 사용자에게 표시할 수도 있습니다.
    }
  }
}
