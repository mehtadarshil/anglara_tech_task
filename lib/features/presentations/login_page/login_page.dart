import 'package:anglara_tech_task/gen/fonts.gen.dart';
import 'package:anglara_tech_task/shared/constants/colors.dart';
import 'package:anglara_tech_task/shared/constants/route_constants.dart';
import 'package:anglara_tech_task/shared/constants/strings.dart';
import 'package:anglara_tech_task/shared/utils/extension/widget_extensions.dart';
import 'package:anglara_tech_task/shared/widgets/common_button.dart';
import 'package:anglara_tech_task/shared/widgets/common_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../blocs/login_bloc/login_bloc_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static final LoginBlocBloc _loginBlocBloc = LoginBlocBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              Strings.strLogin,
              style:
                  TextStyle(fontFamily: FontFamily.poppinsMedium, fontSize: 30),
            ).paddingLeft(15),
            const Text(
              Strings.strLoginToContinue,
              style: TextStyle(
                  fontFamily: FontFamily.poppinsRegular, fontSize: 16),
            ).paddingLeft(15),
            const SizedBox(
              height: 50,
            ),
            CommonTextfield(
              controller: _loginBlocBloc.emailController,
              hintText: Strings.email,
            ).paddingSymmetric(horizontal: 10, vertical: 15),
            CommonTextfield(
              controller: _loginBlocBloc.passwordController,
              hintText: Strings.password,
              obscure: true,
            ).paddingSymmetric(horizontal: 10, vertical: 5),
            CommonButton(
              onPressed: () {
                _loginBlocBloc.add(LoginRequest(context));
              },
              text: Strings.strLogin,
              isLight: false,
            ).paddingSymmetric(horizontal: 10, vertical: 50),
            Center(
              child: Text.rich(TextSpan(children: [
                const TextSpan(
                  text: Strings.strDontHaveAcc,
                  style: TextStyle(
                    fontFamily: FontFamily.poppinsMedium,
                  ),
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(context, RouteList.registerUser,
                          arguments: _loginBlocBloc);
                    },
                  text: Strings.strCreateAccount,
                  style: const TextStyle(
                      fontFamily: FontFamily.poppinsMedium,
                      color: AppColors.primaryColor),
                )
              ])),
            )
          ],
        ),
      ),
    );
  }
}
