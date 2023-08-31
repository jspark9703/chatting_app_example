import 'package:flutter/foundation.dart';

import '../models/message_model.dart';

class HomeProvider extends ChangeNotifier {
  final List<Message> _messages = [
    Message(
      message: "Hello, how are you?",
      senderUsername: "user2",
      sentAt: DateTime(2023, 9, 1, 12, 5, 0),
    ),
    Message(
      message: "I'm doing good, thanks!",
      senderUsername: "user2",
      sentAt: DateTime(2023, 9, 1, 12, 5, 0),
    ),
    Message(
      message: "What are you up to?",
      senderUsername: "user1",
      sentAt: DateTime(2023, 9, 1, 12, 6, 0),
    ),
    Message(
      message: "Just working on a project. You?",
      senderUsername: "user3",
      sentAt: DateTime(2023, 9, 1, 12, 7, 0),
    ),
    Message(
      message: "Watching a movie. Wanna join?",
      senderUsername: "user2",
      sentAt: DateTime(2023, 9, 1, 12, 8, 0),
    ),
    Message(
      message: "Maybe later, I'm a bit busy now.",
      senderUsername: "user2",
      sentAt: DateTime(2023, 9, 1, 12, 10, 0),
    ),
    Message(
      message: "Sure, let me know when you're free.",
      senderUsername: "user1",
      sentAt: DateTime(2023, 9, 1, 12, 12, 0),
    ),
    Message(
      message: "Will do!",
      senderUsername: "user2",
      sentAt: DateTime(2023, 9, 1, 12, 14, 0),
    ),
    Message(
      message: "By the way, have you seen my notebook?",
      senderUsername: "user2",
      sentAt: DateTime(2023, 9, 1, 12, 16, 0),
    ),
    Message(
      message: "Not sure, maybe in the study room?",
      senderUsername: "user1",
      sentAt: DateTime(2023, 9, 1, 12, 18, 0),
    ),
  ];

  List<Message> get messages => _messages;

  addNewMessage(Message message) {
    _messages.insert(0, message);
    notifyListeners();
  }
}
