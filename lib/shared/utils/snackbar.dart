import 'package:anglara_tech_task/shared/constants/colors.dart';
import 'package:flutter/material.dart';

class SnackBarUtil {
  static void showInSnackBar(BuildContext context, String value,
      {Color bgColors = AppColors.primaryColor}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        value,
        style: const TextStyle(fontSize: 16, color: AppColors.whiteColor),
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      backgroundColor: bgColors,
    ));
  }
}
