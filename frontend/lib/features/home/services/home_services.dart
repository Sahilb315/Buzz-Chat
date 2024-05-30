import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class HomeServices {
  static Future<String?> getData(
    String currentUserId,
    String receiverUserId,
    String message,
  ) async {
    final jsonBody = jsonEncode({
      "message": message,
      "senderId": currentUserId,
      "receiverId": receiverUserId
    });
    final res = await http.post(
      Uri.parse(
        "http://localhost:3000/message/send",
      ),
      body: jsonBody,
      headers: {
        "Content-Type": "application/json",
      },
    );
    log(res.body);
  }
}
