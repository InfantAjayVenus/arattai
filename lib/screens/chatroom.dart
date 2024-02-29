import 'package:arattai/widgets/chat_messages.dart';
import 'package:arattai/widgets/new_message.dart';
import 'package:flutter/material.dart';

class Chatroom extends StatelessWidget {
  const Chatroom(this.chatroomId, this.chatroomName, {super.key});
  final String chatroomId;
  final String chatroomName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chatroomName),
      ),
      body: Column(
        children: [
          Expanded(child: ChatMessages(chatroomId)),
          NewMessage(chatroomId),
        ],
      ),
    );
  }
}
