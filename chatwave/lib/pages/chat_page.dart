import 'package:chatwave/components/text_field.dart';
import 'package:chatwave/services/auth/auth_service.dart';
import 'package:chatwave/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
  });

  // text controller
  final TextEditingController _messageController = TextEditingController();
  // chat & auth serrvices
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  // send message
  void sendMessage() async {
    // if message is not empty
    if (_messageController.text.isNotEmpty) {
      // send the message
      await _chatService.sendMessage(receiverID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          // display all messages
          Expanded(child: _buildMessageList()),
          // user input
          _buildUserInput()
        ],
      ),
    );
  }

  // build message list
  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(receiverID, senderID),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return const Center(child: Text("Error"));
        }
        // loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text("Loading..."));
        }
        // No data
        if (snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No messages"));
        }
        // return list view
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Text(data["message"]);
  }

  // build message input
  Widget _buildUserInput() {
    return Row(
      children: [
        // textfield should take up most of the space
        Expanded(
          child: MyTextField(
            controller: _messageController,
            hintText: "Type a message",
            obscureText: false,
          ),
        ),
        // send button
        IconButton(
          onPressed: sendMessage,
          icon: const Icon(
            Icons.send,
          ),
        ),
      ],
    );
  }
}
