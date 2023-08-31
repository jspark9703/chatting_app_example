import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/widget/messages.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../models/message_model.dart';
import '../providers/home.dart';
import 'widget/new_messge.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});
  String userName = "user1";
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late IO.Socket _socket;

  _connectSocket() {
    _socket.onConnect((data) => Logger().d('Connection established'));
    _socket.onConnectError((data) => Logger().d('Connect Error: $data'));
    _socket.onDisconnect((data) => Logger().d('Socket.IO server disconnected'));
    _socket.on(
      'message',
      (data) => Provider.of<HomeProvider>(context, listen: false).addNewMessage(
        Message.fromJson(data),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //Important: If your server is running on localhost and you are testing your app on Android then replace http://localhost:3000 with http://10.0.2.2:3000
    _socket = IO.io(
      'http://10.0.2.2:3000',
      IO.OptionBuilder().setTransports(['websocket']).setQuery(
          {'username': widget.userName}).build(),
    );
    _connectSocket();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(229, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(Icons.arrow_back_ios_new_outlined),
        title: const Center(
            child: Text(
          "경복궁 같이가요!",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )),
        actions: const [
          Icon(Icons.menu_rounded),
          SizedBox(
            width: 16,
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  const SizedBox(
                    width: 300,
                    height: 80,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("sophie"),
                            ],
                          ),
                          Text("경복궁 같이 가요!",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Row(
                            children: [Text("성동구 왕십리")],
                          )
                        ]),
                  )
                ]),
          ),
          Positioned(
            child: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 99,
                  ),
                  Expanded(
                      child: Messages(
                    userName: widget.userName,
                  )),
                  NewMessage(
                    userName: widget.userName,
                    socket: _socket,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
