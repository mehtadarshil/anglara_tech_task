import 'package:anglara_tech_task/gen/fonts.gen.dart';
import 'package:anglara_tech_task/shared/constants/strings.dart';
import 'package:anglara_tech_task/shared/utils/extension/widget_extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserTab extends StatelessWidget {
  const UserTab({super.key});

  @override
  Widget build(BuildContext context) {
    var curentUser = FirebaseAuth.instance.currentUser;
    return Column(
      children: [
        Text.rich(TextSpan(children: [
          const TextSpan(
              text: "${Strings.email} : ",
              style: TextStyle(
                  fontFamily: FontFamily.poppinsSemiBold, fontSize: 15)),
          TextSpan(
              text: curentUser?.email,
              style: const TextStyle(
                  fontFamily: FontFamily.poppinsRegular, fontSize: 15))
        ])).paddingSymmetric(horizontal: 10),
      ],
    );
  }
}
