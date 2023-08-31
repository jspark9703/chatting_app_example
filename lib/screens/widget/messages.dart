import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/home.dart';
import 'package:provider/provider.dart';

import 'chat_bubble.dart';

class Messages extends StatefulWidget {
  const Messages({super.key, required this.userName});
  final String userName;
  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, provider, __) => ListView.builder(
        reverse: true,
        itemCount: provider.messages.length,
        itemBuilder: (context, index) {
          final message = provider.messages[index];
          final beforeMessageUser = index == provider.messages.length - 1
              ? null
              : provider.messages[index + 1].senderUsername;
          final beforeMessageTime = index == provider.messages.length - 1
              ? null
              : provider.messages[index + 1].sentAt;
          return Padding(
            padding: const EdgeInsets.only(right: 8, left: 8),
            child: ChatBubbleMessage(
                userName: widget.userName,
                message: message,
                beforeTime: beforeMessageTime,
                beforeUser: beforeMessageUser),
          );
        },
      ),
    );
  }
}
