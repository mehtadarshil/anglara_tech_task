import 'package:anglara_tech_task/gen/fonts.gen.dart';
import 'package:anglara_tech_task/shared/constants/colors.dart';
import 'package:flutter/material.dart';

class CommonTextfield extends StatelessWidget {
  const CommonTextfield(
      {super.key,
      this.hintText,
      required this.controller,
      this.obscure = false,
      this.onTap,
      this.enables,
      this.onChanged});

  final String? hintText;
  final TextEditingController controller;
  final bool obscure;
  final VoidCallback? onTap;
  final bool? enables;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      onTap: onTap,
      onChanged: onChanged,
      enabled: enables,
      cursorColor: AppColors.primaryColor,
      controller: controller,
      decoration: InputDecoration(
        labelText: hintText,
        floatingLabelStyle: const TextStyle(
            fontFamily: FontFamily.poppinsRegular,
            color: AppColors.primaryColor),
        labelStyle: const TextStyle(
          fontFamily: FontFamily.poppinsLight,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
