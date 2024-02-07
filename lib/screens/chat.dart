import 'package:arattai/screens/chatrooms_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Arattai'),
            actions: [
              IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: const Icon(Icons.exit_to_app_outlined),
              ),
            ],
          ),
          body: ChatroomsList(currentUser!.uid),
        );
      },
    );
    // Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Arattai"),
    //     actions: [
    //       IconButton(
    //           onPressed: () {
    //             FirebaseAuth.instance.signOut();
    //           },
    //           icon: const Icon(Icons.exit_to_app_outlined))
    //     ],

    //   ),
    //   body: const Column(
    //     children: [
    //       Expanded(child: ChatMessages()),
    //       NewMessage(),
    //     ],
    //   ),
    // );
  }
}
