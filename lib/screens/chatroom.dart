import 'package:arattai/widgets/chat_messages.dart';
import 'package:arattai/widgets/new_message.dart';
import 'package:flutter/material.dart';

class Chatroom extends StatelessWidget {
  const Chatroom(this.chatroomId, {super.key});
  final String chatroomId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: ChatMessages(chatroomId)),
          NewMessage(chatroomId),
        ],
      ),
    );
  }
}
