import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(
      {required this.message,
      required this.username,
      required this.isSender,
      this.imageUrl,
      super.key});
  final String message;
  final String username;
  final String? imageUrl;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(username),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              clipBehavior: Clip.hardEdge,
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: isSender
                    ? Theme.of(context).colorScheme.background
                    : Theme.of(context).colorScheme.primaryContainer,
                border: Border.all(
                  color: isSender
                      ? Theme.of(context).colorScheme.onBackground
                      : Theme.of(context).colorScheme.primary,
                ),
                borderRadius: isSender
                    ? const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      )
                    : const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
              ),
              child: Text(
                message,
                textAlign: isSender ? TextAlign.right : TextAlign.left,
                textWidthBasis: TextWidthBasis.longestLine,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
