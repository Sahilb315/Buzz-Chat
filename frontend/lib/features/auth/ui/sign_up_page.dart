import 'dart:io';

import 'package:chat_ws/components/custom_textfield.dart';
import 'package:chat_ws/constants/app_colors.dart';
import 'package:chat_ws/constants/images_path.dart';
import 'package:chat_ws/constants/text_styles.dart';
import 'package:chat_ws/features/auth/provider/image_provider.dart';
import 'package:chat_ws/features/auth/ui/login_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;

  final ImagePicker _imagePicker = ImagePicker();

  Future<void> getImage(BuildContext context) async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (!context.mounted) return;
    if (pickedFile != null) {
      context.read<PickImageProvider>().setImageFile(File(pickedFile.path));
      context.read<PickImageProvider>().setDoesImageExist(true);
    } else {
      context.read<PickImageProvider>().setDoesImageExist(false);
    }
  }

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
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.lightBgColor,
                          borderRadius: BorderRadius.circular(36),
                        ),
                        child: Text(
                          "Sign Up",
                          style: AppStyles.subHeading.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 28,
                            color: AppColors.darkGreenColor,
                          ),
                        ),
                      ),
                    ),
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
                    height: MediaQuery.sizeOf(context).height * 0.7,
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
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () => getImage(context),
                                child: Row(
                                  children: [
                                    Consumer<PickImageProvider>(
                                      builder: (context, value, child) {
                                        return value.doesImageExist
                                            ? CircleAvatar(
                                                radius: 26,
                                                foregroundImage:
                                                    FileImage(value.imageFile!),
                                              )
                                            : const CircleAvatar(
                                                radius: 26,
                                                backgroundColor:
                                                    AppColors.lightBgColor,
                                                foregroundImage: NetworkImage(
                                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdh-7WGKhECkm5SXX_6FS1OxjEZiyEXSKIAQ&s",
                                                ),
                                              );
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      "Add a Profile Pic",
                                      style: AppStyles.normalText.copyWith(
                                        color: AppColors.darkGreenColor,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            isPasswordField: false,
                            title: "Full Name",
                            hintText: "Shane Ramos",
                            controller: TextEditingController(),
                          ),
                          const SizedBox(height: 12),
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
                            hintText: "Must be more than 6 characters",
                            isPasswordField: true,
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(
                                text: "Already have an accout ? ",
                                style: AppStyles.normalText.copyWith(
                                  color: AppColors.darkGreenColor,
                                  fontSize: 15,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Log In",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Navigate to login page
                                        Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                    secondaryAnimation) =>
                                                const LoginPage(),
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
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                  color: AppColors.darkGreenColor,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: isLoading
                                    ? const Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: CircularProgressIndicator(
                                          color: AppColors.bgColor,
                                          strokeCap: StrokeCap.round,
                                          strokeWidth: 2.5,
                                        ),
                                      )
                                    : const Icon(
                                        Icons.arrow_forward_rounded,
                                        color: AppColors.bgColor,
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
              top: MediaQuery.sizeOf(context).height / 8,
              right: 15,
              child: SvgPicture.asset(
                AppImages.personSvg,
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
