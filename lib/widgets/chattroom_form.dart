import 'package:flutter/material.dart';

class ChatroomForm extends StatefulWidget {
  const ChatroomForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChatroomFormState();
  }
}

class _ChatroomFormState extends State<ChatroomForm> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String name = '';
    String description = '';

    onSubmitForm() {
      print(name);
      print(description);
    }

    /**
     * TODO:
     * 1. Name field
     * 2. Description of the Chatroom
     * 3. Invite members by email
     *    1. Members must get an invite which they should accept or reject
     *    2. Status of the invites must be shown
     *    3. Invites must expire in a week
     */
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              autofocus: true,
              decoration: const InputDecoration(
                label: Text('Room Name'),
                hintText: 'Enter Name of the Chatroom',
              ),
              validator: (value) {
                if (value == null || value.isEmpty || value == '') {
                  return 'Name of the Chat room must not be empty';
                }

                return null;
              },
              onSaved: (value) {
                if (value == null) return;
                setState(() {
                  name = value;
                });
              },
            ),
            TextFormField(
              autofocus: true,
              decoration: const InputDecoration(
                label: Text('Room Description'),
                hintText: 'Let everyone know more about the room',
              ),
              onSaved: (value) {
                if (value == null) return;
                setState(() {
                  description = value;
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shadowColor:
                        Theme.of(context).buttonTheme.colorScheme?.error,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    onSubmitForm();
                  },
                  child: const Text('Create Room'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
