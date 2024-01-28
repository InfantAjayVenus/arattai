import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void submitMessage() async {
    final messageText = _messageController.text;

    _messageController.clear();
    if (messageText == '' || messageText.isEmpty) {
      return;
    }

    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    await FirebaseFirestore.instance.collection('chats').add({
      'text': messageText,
      'createdAt': Timestamp.now(),
      'uid': user.uid,
      'username': await userData.data()!['username']
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _messageController,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                cursorHeight: 25,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  hintText: "Enter Your Messages Here.",
                  alignLabelWithHint: false,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                ),
                validator: (value) {
                  return null;
                },
                onFieldSubmitted: (value) {
                  print('Submitting');
                  submitMessage();
                },
              ),
            ),
            IconButton(
              onPressed: () {
                submitMessage();
              },
              icon: const Icon(Icons.send_rounded),
              iconSize: 45,
            )
          ],
        ),
      ),
    );
  }
}
