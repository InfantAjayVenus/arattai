import 'package:arattai/widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("chats")
          .orderBy('createdAt', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text('Something Went Wrong :('),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No Messages Found'),
          );
        }

        final messagesList = snapshot.data!.docs;

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: ListView.builder(
            itemCount: messagesList.length,
            itemBuilder: (context, index) {
              final messageItem = messagesList[index].data();

              return ChatBubble(
                message: messageItem['text'],
                username: messageItem['username'],
                isSender: messageItem['uid'] ==
                    FirebaseAuth.instance.currentUser!.uid,
                imageUrl: messageItem['imageUrl'],
              );
            },
          ),
        );
      },
    );
  }
}
