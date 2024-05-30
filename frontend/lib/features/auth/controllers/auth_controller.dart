import 'dart:convert';

import 'package:chat_ws/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthController {
  static Future<UserSignUpFetchData> signUpUser({
    required String email,
    required String password,
    required String fullName,
    required String profilePicPath,
  }) async {
    try {
      final request = http.MultipartRequest(
          "POST", Uri.parse("${dotenv.env['BASE_URL']}/user/signup"));
      final jsonData = jsonEncode({
        email: email,
        password: password,
        fullName: fullName,
      });
      request.fields['json'] = jsonData;
      request.files.add(
        await http.MultipartFile.fromPath("profilePic", profilePicPath),
      );
      final streamResponse = await request.send();
      final response = await http.Response.fromStream(streamResponse);
      final resData = jsonDecode(response.body);

      if (resData['status'] as bool) {
        return UserSignUpFetchData(
          isUserSignedUp: true,
          userModel: UserModel.fromMap(resData['user']),
        );
      } else {
        return UserSignUpFetchData(
          isUserSignedUp: false,
          errorMessage: resData['message'],
        );
      }
    } catch (e) {
      return UserSignUpFetchData(
        isUserSignedUp: false,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("${dotenv.env['BASE_URL']}/user/login"),
        body: jsonEncode({
          email: email,
          password: password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      final resData = jsonDecode(response.body);

      if (resData['status'] as bool) {
      } else {}
    } catch (e) {}
  }
}

class UserSignUpFetchData {
  final bool isUserSignedUp;
  final UserModel? userModel;
  final String? errorMessage;

  UserSignUpFetchData({
    required this.isUserSignedUp,
    this.userModel,
    this.errorMessage,
  });
}
