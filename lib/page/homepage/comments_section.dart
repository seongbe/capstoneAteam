import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentsSection extends StatelessWidget {
  final String postId;
  final String userId;

  const CommentsSection({Key? key, required this.postId, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('Comment').doc(postId).snapshots(),
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

          // Ensure 'comments' field exists and retrieve its data
          List<dynamic> commentsData = snapshot.data!.get('comment') ?? [];
          List<Map<String, dynamic>> comments = commentsData
              .whereType<Map<String, dynamic>>()
              .toList(); // Convert to List<Map<String, dynamic>>

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

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection('Users').doc(comment['userId']).get(),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (userSnapshot.hasError || !userSnapshot.hasData || !userSnapshot.data!.exists) {
                    return SizedBox(); // Handle error or data absence
                  }

                  String profileUrl = userSnapshot.data!.get('profile_url');

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundImage: profileUrl.isNotEmpty
                              ? NetworkImage(profileUrl)
                              : AssetImage('assets/images/skon_fly.png') as ImageProvider<Object>?,
                        ),
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
                            SizedBox(height: 2.0),
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


                            String replyProfileUrl = reply['profile_url'] ?? '';
                            return Column(
                              children: [
                                Divider(
                                  height: 20.0,
                                  color: Color(0xffD0E4BC),
                                  thickness: 1.0,
                                  indent: 20.0,
                                  endIndent: 20.0,
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.only(left: 20.0),
                                  leading: CircleAvatar(
                                    backgroundImage: replyProfileUrl.isNotEmpty
                                        ? NetworkImage(replyProfileUrl)
                                        : AssetImage('assets/images/skon_fly.png') as ImageProvider<Object>?,
                                  ),
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
          );
        },
      ),
    );
  }
}
