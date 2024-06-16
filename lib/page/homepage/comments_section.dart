import 'package:capstone/page/homepage/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CommentsSection extends StatefulWidget {
  final String postId;
  final String userId;

  CommentsSection({Key? key, required this.postId, required this.userId})
      : super(key: key);

  @override
  _CommentsSectionState createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  late TextEditingController _commentController;
  late TextEditingController _replyController;
  late FocusNode _replyFocusNode;
  bool _isReplying = false;
  late ScrollController _scrollController;
  String? _selectedCommentId;
  late FirebaseAuth _auth;
  late User? _currentUser;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
    _replyController = TextEditingController();
    _replyFocusNode = FocusNode();
    _scrollController = ScrollController();
    _auth = FirebaseAuth.instance;
    _currentUser = _auth.currentUser;

  }

  @override
  void dispose() {
    _commentController.dispose();
    _replyController.dispose();
    _replyFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _addComment() async {
    if (_commentController.text.isEmpty) return;

    try {
      CollectionReference commentsCollection = FirebaseFirestore.instance.collection('Comment');
      Timestamp timestamp = Timestamp.now();
      String userNickname = 'Unknown'; // Default value

      if (_currentUser != null) {
        userNickname = await _getPostOwnerNickname(_currentUser!.uid);
      } else {
        print('Current user is null. Cannot add comment.');
        return; // Return early if current user is null
      }

      // Generate unique comment_id using UUID
      String commentId = FirebaseFirestore.instance.collection('Comment').doc().id;

      Map<String, dynamic> commentData = {
        'comment_id': commentId,
        'content': _commentController.text,
        'created_at': timestamp,
        'nickname': userNickname,
        'user_id': _currentUser!.uid,
        'replies': [],
      };

      DocumentReference postRef = commentsCollection.doc(widget.postId);
      DocumentSnapshot postSnapshot = await postRef.get();

      if (postSnapshot.exists) {
        List<dynamic> comments = postSnapshot.get('comment') ?? [];
        comments.add(commentData);
        await postRef.update({'comment': comments});
      } else {
        await postRef.set({
          'comment': [commentData]
        });
      }

      _commentController.clear();
    } catch (e) {
      print('Error adding comment: $e');
    }
  }


  Future<String> _getPostOwnerNickname(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('User').doc(userId).get();

      if (userDoc.exists) {
        return userDoc.get('nickname');
      }

      return 'Unknown';
    } catch (e) {
      print('Error getting post owner nickname: $e');
      return 'Unknown';
    }
  }

  Future<String> _getPostOwnerProfileUrl(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('User').doc(userId).get();

      if (userDoc.exists) {
        return userDoc.get('profile_url') ?? 'No profile URL';
      }

      return 'Unknown';
    } catch (e) {
      print('Error getting post owner profile URL: $e');
      return 'Unknown';
    }
  }

  void _startReply(String commentId) {
    setState(() {
      _isReplying = true;
      _selectedCommentId = commentId; // Set selected comment id for reply
    });

    // Focus on reply text field
    _replyFocusNode.requestFocus();

    // Scroll to the reply text field
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void _cancelReply() {
    setState(() {
      _isReplying = false;
      _selectedCommentId = null; // Clear selected comment id
    });

    _replyController.clear();
    _replyFocusNode.unfocus();
  }

  Future<void> _submitReply() async {
    if (_replyController.text.isEmpty || _selectedCommentId == null) return;

    try {
      CollectionReference commentsCollection =
          FirebaseFirestore.instance.collection('Comment');
      Timestamp timestamp = Timestamp.now();
      String userNickname = 'Unknown';

      if (_currentUser != null) {
        userNickname = await _getPostOwnerNickname(_currentUser!.uid);
      }

      Map<String, dynamic> replyData = {
        'content': _replyController.text,
        'created_at': timestamp,
        'nickname': userNickname,
        'user_id': _currentUser!.uid
      };

      DocumentReference postRef = commentsCollection.doc(widget.postId);
      DocumentSnapshot postSnapshot = await postRef.get();

      if (postSnapshot.exists) {
        List<dynamic> comments = postSnapshot.get('comment') ?? [];
        // Find the comment to reply to
        for (var comment in comments) {
          if (comment['comment_id'] == _selectedCommentId) {
            List<dynamic> replies = comment['replies'] ?? [];
            replies.add(replyData);
            await postRef.update({'comment': comments});
            break;
          }
        }
      }

      _replyController.clear();
      _replyFocusNode.unfocus();
      setState(() {
        _isReplying = false;
        _selectedCommentId = null; // Clear selected comment id after reply
      });
    } catch (e) {
      print('Error submitting reply: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      labelText: '댓글을 달아 소통해보세요!',
                      labelStyle: TextStyle(
                        fontFamily: 'skybori',
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: Color(0xffF8FFF2),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffD0E4BC)),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffD0E4BC)),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 15.0),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                    cursorColor: Colors.green,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addComment,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF78BE39),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(
                        color: Color(0xFF66AA28),
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Text(
                    '댓글달기',
                    style: TextStyle(
                      fontFamily: 'mitmi',
                      fontSize: 14.0,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Comment')
                  .doc(widget.postId)
                  .snapshots(),
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
                      '아직 댓글이 없습니다!\n댓글을 달아 판매자와 소통해보세요!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'skybori',
                      ),
                    ),
                  );
                }

                List<dynamic> commentsData =
                    snapshot.data!.get('comment') ?? [];
                List<Map<String, dynamic>> comments =
                    commentsData.whereType<Map<String, dynamic>>().toList();

                if (comments.isEmpty) {
                  return Center(
                    child: Text(
                      '아직 댓글이 없습니다!\n댓글을 달아 판매자와 소통해보세요!',
                      textAlign: TextAlign.center,
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
                    _formatTimestamp formatter =
                        _formatTimestamp(commentTimestamp);

                    // 프로필 URL 가져오기
                    Future<String> profileUrlFuture =
                        _getPostOwnerProfileUrl(comment['user_id']);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<String>(
                          future: profileUrlFuture,
                          builder: (context, snapshot) {
                            String profileUrl = snapshot.data ?? '';

                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() =>
                                          UserDetail(uid: comment['user_id']));
                                    },
                                    child: CircleAvatar(
                                      backgroundImage: profileUrl.isNotEmpty
                                          ? NetworkImage(profileUrl)
                                          : AssetImage(' ')
                                              as ImageProvider, // 기본 프로필 이미지 설정
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          comment['nickname'] ?? '',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontFamily: 'skybori',
                                            fontWeight: FontWeight.w300,
                                            height: 0.9,
                                          ),
                                        ),
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
                                          '${formatter.formatTimestamp()}',
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
                              ),
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {
                              _startReply(comment['comment_id']);
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
                        if (_isReplying &&
                            _selectedCommentId == comment['comment_id'])
                          Container(
                            padding: EdgeInsets.only(left: 40.0, right: 20.0),
                            child: TextField(
                              controller: _replyController,
                              focusNode: _replyFocusNode,
                              onSubmitted: (_) => _submitReply(),
                              decoration: InputDecoration(
                                hintText: '답글을 입력하세요.',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Color(0xffF8FFF2),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 15.0,
                                ),
                              ),
                            ),
                          ),
                        if (_isReplying &&
                            _selectedCommentId == comment['comment_id'])
                          Container(
                            alignment: Alignment.centerRight,
                            margin: EdgeInsets.only(right: 20.0),
                            child: TextButton(
                              onPressed: _cancelReply,
                              child: Text(
                                '취소',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontFamily: 'skybori',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
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
                              _formatTimestamp replyFormatter =
                                  _formatTimestamp(replyTimestamp);

                              return Column(
                                children: [
                                  FutureBuilder<String>(
                                    future: _getPostOwnerProfileUrl(
                                        reply['user_id']),
                                    builder: (context, snapshot) {
                                      String replyProfileUrl =
                                          snapshot.data ?? '';

                                      return ListTile(
                                        contentPadding:
                                            EdgeInsets.only(left: 18.5),
                                        title: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: replyProfileUrl
                                                      .isNotEmpty
                                                  ? NetworkImage(
                                                      replyProfileUrl)
                                                  : AssetImage(' ')
                                                      as ImageProvider, // 기본 프로필 이미지 설정
                                            ),
                                            SizedBox(width: 8.0),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    reply['nickname'] ?? '',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontFamily: 'skybori',
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      height: 0.9,
                                                    ),
                                                  ),
                                                  Text(
                                                    reply['content'] ?? '',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontFamily: 'skybori',
                                                      fontWeight:
                                                          FontWeight.w100,
                                                      height: 1.2,
                                                    ),
                                                  ),
                                                  SizedBox(height: 2.0),
                                                  // 답글 작성 시간 표시
                                                  Text(
                                                    '작성 시간: ${replyFormatter.formatTimestamp()}',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                      fontFamily: 'skybori',
                                                      fontWeight:
                                                          FontWeight.w300,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.0),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
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
      ),
    );
  }
}

class _formatTimestamp {
  late Timestamp _timestamp;

  _formatTimestamp(Timestamp timestamp) {
    _timestamp = timestamp;
  }

  String formatTimestamp() {
    DateTime dateTime = _timestamp.toDate();
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);
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
