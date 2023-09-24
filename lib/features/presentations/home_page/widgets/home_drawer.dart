import 'package:anglara_tech_task/di/app_component_base.dart';
import 'package:anglara_tech_task/gen/fonts.gen.dart';
import 'package:anglara_tech_task/shared/constants/colors.dart';
import 'package:anglara_tech_task/shared/constants/route_constants.dart';
import 'package:anglara_tech_task/shared/constants/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(15))),
      backgroundColor: AppColors.whiteColor,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const ListTile(
            title: Text(
              Strings.strCategories,
              style: TextStyle(
                  fontFamily: FontFamily.poppinsSemiBold, fontSize: 16),
            ),
            leading: Icon(
              Icons.category_rounded,
              color: AppColors.blackColor,
            ),
          ),
          const ListTile(
            title: Text(
              Strings.strUserProfile,
              style: TextStyle(
                  fontFamily: FontFamily.poppinsSemiBold, fontSize: 16),
            ),
            leading: Icon(
              Icons.person_rounded,
              color: AppColors.blackColor,
            ),
          ),
          ListTile(
            onTap: () async {
              AppComponentBase.instance.showProgressDialog();
              FirebaseAuth.instance.signOut().then((value) {
                AppComponentBase.instance.hideProgressDialog();
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteList.initial, (route) => false);
              });
            },
            title: const Text(
              Strings.strLogOut,
              style: TextStyle(
                  fontFamily: FontFamily.poppinsSemiBold, fontSize: 16),
            ),
            leading: const Icon(
              Icons.logout_rounded,
              color: AppColors.blackColor,
            ),
          )
        ],
      ),
    );
  }
}
