import 'package:arattai/widgets/chattroom_form.dart';
import 'package:flutter/material.dart';

class NewChatroom extends StatelessWidget {
  const NewChatroom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Chat Room'),
      ),
      body: const Center(
        child: ChatroomForm(),
      ),
    );
  }
}
