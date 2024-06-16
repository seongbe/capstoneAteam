import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentsSection extends StatefulWidget {
  final String postId;
  final String userId;

  CommentsSection({Key? key, required this.postId, required this.userId}) : super(key: key);

  @override
  _CommentsSectionState createState() => _CommentsSectionState();
}
Future<String> _getUserNickname(String userId) async {
  try {
    // Firebase Auth에서 현재 사용자 가져오기
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Firestore에서 User 컬렉션의 해당 사용자 정보 가져오기
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('User').doc(userId).get();
      if (userDoc.exists) {
        // 사용자의 닉네임 반환
        return userDoc.get('nickname');
      }
    }
    return 'Unknown';
  } catch (e) {
    print('Error getting user nickname: $e');
    return 'Unknown';
  }
}

Future<String> _getUserProfile(String userId) async {
  try {
    // Firebase Auth에서 현재 사용자 가져오기
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Firestore에서 User 컬렉션의 해당 사용자 정보 가져오기
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('User').doc(userId).get();
      if (userDoc.exists) {
        // 사용자의 프로필 경로 반환
        return userDoc.get('profile_url');
      }
    }
    return 'Unknown';
  } catch (e) {
    print('Error getting user profile_url: $e');
    return 'Unknown';
  }
}

class _CommentsSectionState extends State<CommentsSection> {
  late TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
  }

  void _addComment() async {
    if (_commentController.text.isEmpty) return;

    try {
      // Firestore에 댓글 추가
      CollectionReference commentsCollection = FirebaseFirestore.instance.collection('Comment');

      // 현재 시간 가져오기 (타임스탬프 형식)
      Timestamp timestamp = Timestamp.now();

      String userNickname = await _getUserNickname(widget.userId);

      // 댓글 데이터 준비
      Map<String, dynamic> commentData = {
        'content': _commentController.text,
        'created_at': timestamp,
        'nickname': userNickname, // 사용자 닉네임 (또는 사용자 이름)
        'user_id': widget.userId, // 사용자 UID
      };

      // 해당 게시물에 댓글 추가
      DocumentReference postRef = commentsCollection.doc(widget.postId);
      DocumentSnapshot postSnapshot = await postRef.get();

      if (postSnapshot.exists) {
        // 이미 존재하는 경우 comments 필드에 추가
        List<dynamic> comments = postSnapshot.get('comment') ?? [];
        comments.add(commentData);
        await postRef.update({'comment': comments});
      } else {
        // 존재하지 않는 경우 새로운 문서 생성
        await postRef.set({'comment': [commentData]});
      }

      // 댓글 작성 후 입력창 비우기
      _commentController.clear();
    } catch (e) {
      print('Error adding comment: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    labelText: '댓글을 달아 소통해보세요 !',
                    labelStyle: TextStyle(
                      fontFamily: 'skybori', // 폰트 설정
                      color: Colors.grey, // 기본 라벨 텍스트 색상 설정
                    ),
                    filled: true, // 배경 색상 적용 여부
                    fillColor: Color(0xffF8FFF2), // 배경 색상 설정
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD0E4BC)), // 테두리 색상 설정
                      borderRadius: BorderRadius.all(Radius.circular(15.0)), // 테두리 모서리 둥글게 설정
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffD0E4BC)), // 포커스된 테두리 색상 설정
                      borderRadius: BorderRadius.all(Radius.circular(15.0)), // 포커스된 테두리 모서리 둥글게 설정
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                    floatingLabelBehavior: FloatingLabelBehavior.auto, // 라벨이 위로 올라갔을 때만 색상 설정
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // 포커스된 에러 테두리 색상 설정
                      borderRadius: BorderRadius.all(Radius.circular(15.0)), // 포커스된 에러 테두리 모서리 둥글게 설정
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // 에러 테두리 색상 설정
                      borderRadius: BorderRadius.all(Radius.circular(15.0)), // 에러 테두리 모서리 둥글게 설정
                    ),
                  ),
                  cursorColor: Colors.green, // 커서 색상 설정
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _addComment,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Color(0xFF78BE39), // 텍스트 색상 설정
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0), // 내부 패딩 설정
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(
                      color: Color(0xFF66AA28), // 버튼 테두리 색상 설정
                      width: 1.0, // 버튼 테두리 두께 설정
                    ),// 버튼 모서리 둥글기 설정
                  ),
                ),
                child: Text(
                  '댓글달기',
                  style: TextStyle(
                    fontFamily: 'mitmi', // 폰트 설정
                    fontSize: 14.0, // 텍스트 크기 설정
                    letterSpacing: 1.0, // 자간 설정
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance.collection('Comment').doc(widget.postId).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('댓글을 불러오는 중 오류가 발생했습니다.'));
              }

              if (!snapshot.hasData || !snapshot.data!.exists) {
                return Center(
                  child: Text(
                    '아직 댓글이 없습니다 !\n댓글을 달아 판매자와 소통해보세요 !',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'skybori',
                    ),
                  ),
                );
              }

              List<dynamic> commentsData = snapshot.data!.get('comment') ?? [];
              List<Map<String, dynamic>> comments = commentsData
                  .whereType<Map<String, dynamic>>()
                  .toList();

              if (comments.isEmpty) {
                return Center(
                  child: Text(
                    '아직 댓글이 없습니다 !\n댓글을 달아 판매자와 소통해보세요 !',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'skybori',
                    ),
                  ),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                itemCount: comments.length,
                itemBuilder: (context, index) {
                  var comment = comments[index];
                  List<dynamic>? repliesData = comment['replies'];
                  List<Map<String, dynamic>> replies = repliesData != null
                      ? repliesData.whereType<Map<String, dynamic>>().toList()
                      : [];

                  // 댓글 작성 시간 가져오기
                  Timestamp commentTimestamp = comment['created_at'];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          comment['nickname'] ?? '',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'skybori',
                            fontWeight: FontWeight.w300,
                            height: 0.9,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 4.0),
                            Text(
                              comment['content'] ?? '',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'skybori',
                                fontWeight: FontWeight.w100,
                                height: 1.2,
                              ),
                            ),
                            SizedBox(height: 2.0),
                            // 댓글 작성 시간 표시
                            Text(
                              '작성 시간: ${_formatTimestamp(commentTimestamp)}', // timestamp 포맷팅 함수 호출
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontFamily: 'skybori',
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {
                                  // Handle reply button tap
                                },
                                child: Text(
                                  '답글 달기',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                    fontFamily: 'skybori',
                                    fontWeight: FontWeight.w400,
                                    height: 1.2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (replies.isNotEmpty)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: replies.length,
                          itemBuilder: (context, replyIndex) {
                            var reply = replies[replyIndex];

                            // 답글 작성 시간 가져오기
                            Timestamp replyTimestamp = reply['created_at'];

                            return Column(
                              children: [
                                Divider(
                                  height: 0,
                                  color: Color(0xffd3e1c5),
                                  thickness: 0.5,
                                  indent: 20.0,
                                  endIndent: 20.0,
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.only(left: 18.5),
                                  title: Text(
                                    reply['nickname'] ?? '',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'skybori',
                                      fontWeight: FontWeight.w300,
                                      height: 0.9,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        reply['content'] ?? '',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'skybori',
                                          fontWeight: FontWeight.w100,
                                          height: 1.2,
                                        ),
                                      ),
                                      SizedBox(height: 2.0),
                                      // 답글 작성 시간 표시
                                      Text(
                                        '작성 시간: ${_formatTimestamp(replyTimestamp)}', // timestamp 포맷팅 함수 호출
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontFamily: 'skybori',
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _formatTimestamp {
  _formatTimestamp(Timestamp commentTimestamp);

  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate(); // Timestamp를 DateTime 객체로 변환

    // 현재 시간
    DateTime now = DateTime.now();

    // 차이 계산
    Duration difference = now.difference(dateTime);

    // 차이가 얼마나 되는지에 따라 다른 문자열 반환
    if (difference.inDays > 0) {
      return '${difference.inDays}일 전';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}시간 전';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}분 전';
    } else {
      return '방금 전';
    }
  }

}
