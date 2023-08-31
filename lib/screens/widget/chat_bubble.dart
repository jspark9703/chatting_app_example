import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/message_model.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:intl/intl.dart';

class ChatBubbleMessage extends StatefulWidget {
  final String userName;
  final Message message;
  final String? beforeUser;
  final DateTime? beforeTime;
  const ChatBubbleMessage(
      {super.key,
      required this.userName,
      required this.message,
      this.beforeUser,
      this.beforeTime});

  @override
  State<ChatBubbleMessage> createState() => _ChatBubbleMessageState();
}

class _ChatBubbleMessageState extends State<ChatBubbleMessage> {
  @override
  Widget build(BuildContext context) {
    return widget.userName == widget.message.senderUsername
        ? Padding(
            padding: widget.userName == widget.beforeUser
                ? const EdgeInsets.only(top: 6)
                : const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 27,
                    ),
                    Text(
                      DateFormat('hh:mm a').format(widget.message.sentAt),
                      style: const TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ],
                ),
                ChatBubble(
                  clipper: ChatBubbleClipper5(type: BubbleType.sendBubble),
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.only(left: 4),
                  backGroundColor: Colors.blue,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    child: Text(
                      widget.message.message,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        //다른유저
        : Padding(
            padding: widget.message.senderUsername == widget.beforeUser
                ? const EdgeInsets.only(top: 6)
                : const EdgeInsets.only(top: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.message.senderUsername == widget.beforeUser
                    ? const SizedBox(
                        width: 35,
                      )
                    : const Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          maxRadius: 16,
                        ),
                      ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.message.senderUsername == widget.beforeUser
                        ? const SizedBox(
                            height: 1,
                          )
                        : Text(
                            widget.message.senderUsername,
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ChatBubble(
                          clipper: ChatBubbleClipper5(
                              type: BubbleType.receiverBubble),
                          alignment: Alignment.topRight,
                          margin: const EdgeInsets.only(right: 4),
                          backGroundColor: Colors.white,
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: Text(
                              widget.message.message,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 27,
                            ),
                            Text(
                              DateFormat('hh:mm a')
                                  .format(widget.message.sentAt),
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 10),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
