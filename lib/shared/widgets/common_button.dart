import 'package:anglara_tech_task/gen/fonts.gen.dart';
import 'package:anglara_tech_task/shared/constants/colors.dart';
import 'package:anglara_tech_task/shared/constants/strings.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {super.key,
      required this.onPressed,
      this.isLight = false,
      required this.text});

  final VoidCallback onPressed;
  final bool isLight;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              surfaceTintColor: AppColors.transparentColor,
              shadowColor: AppColors.transparentColor,
              backgroundColor: isLight
                  ? AppColors.primaryLightColor
                  : AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2))),
          onPressed: onPressed,
          child: Text(
            Strings.strLogin,
            style: TextStyle(
                fontFamily: FontFamily.poppinsSemiBold,
                fontSize: 15,
                color: isLight ? AppColors.primaryColor : null),
          )),
    );
  }
}
