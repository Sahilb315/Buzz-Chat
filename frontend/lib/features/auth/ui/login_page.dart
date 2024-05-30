import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:chat_ws/components/custom_textfield.dart';
import 'package:chat_ws/constants/app_colors.dart';
import 'package:chat_ws/constants/images_path.dart';
import 'package:chat_ws/constants/text_styles.dart';
import 'package:chat_ws/features/auth/ui/sign_up_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.darkGreenColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Transform.rotate(
                            angle: -math.pi / 18,
                            alignment: Alignment.topRight,
                            child: Container(
                              alignment: Alignment.topRight,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 28,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.lightBgColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(36),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "",
                                  style: AppStyles.subHeading.copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 28,
                                    color: AppColors.darkGreenColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Align(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Transform.rotate(
                              angle: -math.pi / 160,
                              alignment: Alignment.topCenter,
                              child: Container(
                                alignment: Alignment.topRight,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.lightBgColor,
                                  borderRadius: BorderRadius.circular(36),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Login",
                                    style: AppStyles.subHeading.copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 28,
                                      color: AppColors.darkGreenColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.only(
                      top: 12,
                      right: 16,
                      left: 16,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                    ),
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height * 0.5,
                    decoration: BoxDecoration(
                      color: AppColors.bgColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          blurRadius: 6,
                          spreadRadius: 2,
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          CustomTextField(
                            title: "Email",
                            hintText: "ragvo@google.com",
                            controller: TextEditingController(),
                            isPasswordField: false,
                          ),
                          const SizedBox(height: 12),
                          CustomTextField(
                            title: "Password",
                            controller: TextEditingController(),
                            hintText: "**********",
                            isPasswordField: true,
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(
                                text: "Don't have an accout ? ",
                                style: AppStyles.normalText.copyWith(
                                  color: AppColors.darkGreenColor,
                                  fontSize: 15,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Sign Up",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Navigate to login page
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                    secondaryAnimation) =>
                                                const SignUpPage(),
                                            transitionsBuilder: (context,
                                                animation,
                                                secondaryAnimation,
                                                child) {
                                              var begin = const Offset(-1, 0.0);
                                              var end = Offset.zero;
                                              var curve = Curves.easeInOut;
                                              var tween = Tween(
                                                begin: begin,
                                                end: end,
                                              ).chain(CurveTween(curve: curve));

                                              return SlideTransition(
                                                position:
                                                    animation.drive(tween),
                                                child: child,
                                              );
                                            },
                                          ),
                                        );
                                      },
                                    style: AppStyles.normalText.copyWith(
                                      color: AppColors.darkGreenColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isLoading = !isLoading;
                                });
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                width: double.maxFinite,
                                decoration: BoxDecoration(
                                  color: AppColors.darkGreenColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: isLoading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            color: AppColors.bgColor,
                                            strokeCap: StrokeCap.round,
                                            strokeWidth: 2.5,
                                          ),
                                        )
                                      : Text(
                                          "Login",
                                          style: AppStyles.heading.copyWith(
                                            fontSize: 14,
                                            color: AppColors.bgColor,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.sizeOf(context).height / 3,
              right: 15,
              child: SvgPicture.asset(
                AppImages.loginImage,
                height: 150,
                width: 120,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
