// ignore_for_file: library_prefixes

import 'package:chat_ws/constants/app_colors.dart';
import 'package:chat_ws/features/home/services/home_services.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:developer';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  IO.Socket socket = IO.io(
    "http://localhost:3000",
    IO.OptionBuilder().setTransports(['websocket']).setQuery({
      "userID": "6651ac36cf94a7c8775cdb15",
    }).build(),
  );

  void _connectServer() {
    socket.onConnect((data) => log("Connected: $data"));
    socket.onConnectError((data) => log("Error while connecting: $data"));
    socket.on("message", (data) => log("Data is: $data"));
    socket.onDisconnect((data) => log("Disconnected: $data"));
  }

  final String currentUserId = "6651ac36cf94a7c8775cdb15";
  final String receiverUserId = "6651ac36cf94a7c8775cdb14";
  // late StreamSubscription streamController;
  @override
  void initState() {
    super.initState();
    _connectServer();
  }

  final TextEditingController _chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.lightBgColor,
        title: const Text("Chat WS"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Spacer(),
            TextField(
              controller: _chatController,
              decoration: InputDecoration(
                suffixIconColor: AppColors.greenColor,
                suffixIcon: InkWell(
                  onTap: () async {
                    if (_chatController.text.isEmpty) return;
                    await HomeServices.getData(
                      currentUserId,
                      receiverUserId,
                      _chatController.text.trim(),
                    );
                    setState(() {
                      _chatController.clear();
                    });
                  },
                  child: const Icon(Icons.send),
                ),
                border: const OutlineInputBorder(),
                errorBorder: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(),
                hintText: "Enter your message",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
