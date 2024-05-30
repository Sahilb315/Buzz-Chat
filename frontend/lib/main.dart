// ignore_for_file: library_prefixes

import 'package:chat_ws/constants/app_colors.dart';
import 'package:chat_ws/features/auth/provider/image_provider.dart';
import 'package:chat_ws/features/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final token = preferences.getString("token");
  await dotenv.load(fileName: '.env');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PickImageProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

/// HAVE TO ADD CONNECTIVITY PACKAGE & MANAGE IF THERE IS NO NETWORK

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const OnBoardingPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.blackColor,
          selectionColor: AppColors.lightBgColor.withOpacity(1),
          selectionHandleColor: AppColors.greenColor,
        ),
      ),
    );
  }
}
