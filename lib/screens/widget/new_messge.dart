import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class NewMessage extends StatefulWidget {
  final String userName;
  final IO.Socket socket;
  const NewMessage({super.key, required this.userName, required this.socket});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  late IO.Socket _socket;
  final TextEditingController _messageInputController = TextEditingController();
  _sendMessage() {
    _socket.emit('message', {
      'message': _messageInputController.text.trim(),
      'sender': widget.userName
    });

    _messageInputController.clear();
  }

  @override
  void initState() {
    super.initState();
    //Important: If your server is running on localhost and you are testing your app on Android then replace http://localhost:3000 with http://10.0.2.2:3000
    _socket = widget.socket;
  }

  @override
  void dispose() {
    // 텍스트에디팅컨트롤러를 제거하고, 등록된 리스너도 제거된다.
    _messageInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(color: Colors.white),
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _messageInputController,
            style: const TextStyle(fontSize: 15),
            decoration: const InputDecoration(
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Icon(Icons.attach_file_sharp), Icon(Icons.photo)],
                ),
                isDense: true,
                contentPadding: EdgeInsets.all(8),
                filled: true,
                fillColor: Color.fromARGB(97, 158, 158, 158),
                hintText: "메세지를 입력하세요",
                hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(20)))),
            maxLines: null,
          )),
          IconButton(
            onPressed: () {
              if (_messageInputController.text.trim().isNotEmpty) {
                Logger().d(_messageInputController.text);
                _sendMessage();
              }
            },
            icon: const Icon(Icons.send),
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
