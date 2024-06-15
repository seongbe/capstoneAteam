import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ChatPage2 extends StatefulWidget {
  final String chatRoomId;
  final String productOwnerId;

  ChatPage2({required this.chatRoomId, required this.productOwnerId});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage2> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _sendMessage() async {
    if (_messageController.text.isEmpty) return;

    final User? user = _auth.currentUser;
    if (user == null) return;

    await _firestore.collection('chatRooms')
      .doc(widget.chatRoomId)
      .collection('messages')
      .add({
        'senderId': user.uid,
        'message': _messageController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

    _messageController.clear();
  }

  Future<String> _getUserNickname(String userId) async {
    DocumentSnapshot userDoc = await _firestore.collection('User').doc(userId).get();
    return userDoc['nickname'] ?? 'Unknown';
  }

  String _formatTimestamp(Timestamp timestamp) {
    var format = DateFormat('yyyy-MM-dd HH:mm'); // 'yyyy-MM-dd HH:mm:ss' 형태로 표시
    return format.format(timestamp.toDate());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('채팅'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('chatRooms')
                .doc(widget.chatRoomId)
                .collection('messages')
                .orderBy('timestamp', descending: true)
                .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final messageText = message['message'];
                    final senderId = message['senderId'];
                    final timestamp = message['timestamp'] as Timestamp;
                    final isMe = senderId == _auth.currentUser?.uid;

                    return FutureBuilder<String>(
                      future: _getUserNickname(senderId),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }

                        final nickname = snapshot.data!;

                        return ListTile(
                          title: Align(
                            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  nickname,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                  decoration: BoxDecoration(
                                    color: isMe ? Colors.blue : Colors.grey,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Text(
                                    messageText,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  _formatTimestamp(timestamp),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: '메시지를 입력하세요...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
