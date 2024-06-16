import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentsSection extends StatefulWidget {
  final String postId;
  final String userId;

  CommentsSection({Key? key, required this.postId, required this.userId}) : super(key: key);

  @override
  _CommentsSectionState createState() => _CommentsSectionState();
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
      DocumentReference postRef = FirebaseFirestore.instance.collection('Comment').doc(widget.postId);
      DocumentSnapshot postSnapshot = await postRef.get();

      if (postSnapshot.exists) {
        List<dynamic> comments = postSnapshot.get('comments') ?? [];
        comments.add({
          'nickname': widget.userId, // Replace with actual user nickname
          'content': _commentController.text,
          'replies': [],
        });

        await postRef.update({'comments': comments});
      } else {
        await postRef.set({
          'comments': [
            {
              'nickname': widget.userId, // Replace with actual user nickname
              'content': _commentController.text,
              'replies': [],
            }
          ],
        });
      }

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
                  ),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _addComment,
                child: Text('댓글 달기'),
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
                            SizedBox(height:4.0),
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

                            return Column(
                              children: [
                                Divider(
                                  height: 20.0,
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
                                  subtitle: Text(
                                    reply['content'] ?? '',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'skybori',
                                      fontWeight: FontWeight.w100,
                                      height: 1.2,
                                    ),
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
