import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:template_riverpod_go_router/configs/route/routes.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static ChatScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const ChatScreen();

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _messageController = TextEditingController();
  late User _user;
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _checkAuthState();
    _scrollController = ScrollController();
  }

  void _checkAuthState() async {
    final User? user = _auth.currentUser;
    if (user == null) {
      // User is not authenticated, navigate to login screen
      context.push(RouteLocation.login);
    } else {
      setState(() {
        _user = user;
      });
    }
  }

  void _sendMessage() async {
    final String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      await _firestore.collection('messages').add({
        'text': messageText,
        'sender': _user.email,
        'timestamp': Timestamp.now(),
      });
      _messageController.clear();
      if (_scrollController != null) {
        _scrollController!.animateTo(
          _scrollController!.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _auth.signOut();
              context.push(RouteLocation.home);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final messages = snapshot.data?.docs;
                List<Widget> messageWidgets = [];
                if (messages != null) {
                  for (var message in messages) {
                    final Map<String, dynamic>? messageData =
                        message.data() as Map<String, dynamic>?;
                    final messageText = messageData?['text'];
                    final messageSender = messageData?['sender'];
                    if (messageText != null && messageSender != null) {
                      final messageWidget = MessageBubble(
                        text: messageText,
                        sender: messageSender,
                        isMe: messageSender == _user.email,
                      );
                      messageWidgets.add(messageWidget);
                    }
                  }
                }
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  _scrollController!.animateTo(
                    _scrollController!.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                });
                return ListView(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20.0),
                  children: messageWidgets,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
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

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.text,
    required this.sender,
    required this.isMe,
  }) : super(key: key);

  final String text;
  final String sender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? Colors.blueAccent : Colors.grey[300],
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15.0,
                  color: isMe ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
