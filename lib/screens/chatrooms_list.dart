import 'package:arattai/screens/chatroom.dart';
import 'package:arattai/screens/new_chatroom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatroomsList extends StatelessWidget {
  const ChatroomsList(this.currentUserId, {super.key});
  final String currentUserId;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('rooms')
          .where('users', arrayContains: currentUserId)
          .orderBy('lastUpdated')
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

        final userChatRooms = snapshot.data!.docs;

        return Scaffold(
          body: ListView.builder(
            itemCount: userChatRooms.length,
            itemBuilder: (context, index) {
              final chatRoom = userChatRooms[index].data();
              return ListTile(
                title: Text(chatRoom['name']),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return Chatroom(
                          userChatRooms[index].id, chatRoom['name']);
                    },
                  ));
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const NewChatroom();
                  },
                ),
              );
            },
            child: const Icon(Icons.message),
          ),
        );
      },
    );
  }
}
