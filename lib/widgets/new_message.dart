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
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            width: 1,
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextFormField(
                  controller: _messageController,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  enableSuggestions: true,
                  cursorHeight: 25,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                    hintText: "Enter Your Messages Here.",
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    submitMessage();
                  },
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  border: const Border(
                    left: BorderSide(
                      width: 1,
                    ),
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  )),
              child: IconButton(
                onPressed: () {
                  submitMessage();
                },
                icon: const Icon(Icons.send_rounded),
                iconSize: 45,
              ),
            )
          ],
        ),
      ),
    );
  }
}
