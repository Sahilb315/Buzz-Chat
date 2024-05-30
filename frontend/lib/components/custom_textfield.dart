
import 'package:chat_ws/constants/app_colors.dart';
import 'package:chat_ws/constants/text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.title,
    this.hintText,
    required this.controller,
    required this.isPasswordField,
    this.onTap,

  });

  final String title;
  final String? hintText;
  final TextEditingController controller;
  final bool isPasswordField;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            title,
            style: AppStyles.subHeading.copyWith(
              fontSize: 16,
              color: AppColors.blackColor,
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          onTap: isPasswordField ? onTap : null,
          controller: controller,
          obscureText: isPasswordField,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.blackColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(26)),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.blackColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(26)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.blackColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(26)),
            ),
            hintText: hintText,
            hintStyle: AppStyles.normalText.copyWith(
              color: AppColors.darkGreenColor.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}
