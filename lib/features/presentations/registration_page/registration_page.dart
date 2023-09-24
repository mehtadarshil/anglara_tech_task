import 'package:anglara_tech_task/features/blocs/login_bloc/login_bloc_bloc.dart';
import 'package:anglara_tech_task/gen/fonts.gen.dart';
import 'package:anglara_tech_task/shared/constants/colors.dart';
import 'package:anglara_tech_task/shared/constants/strings.dart';
import 'package:anglara_tech_task/shared/utils/extension/widget_extensions.dart';
import 'package:anglara_tech_task/shared/widgets/common_button.dart';
import 'package:anglara_tech_task/shared/widgets/common_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterUser extends StatelessWidget {
  const RegisterUser({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc =
        ModalRoute.of(context)!.settings.arguments as LoginBlocBloc;
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
              Strings.strRegister,
              style:
                  TextStyle(fontFamily: FontFamily.poppinsMedium, fontSize: 30),
            ).paddingLeft(15),
            const Text(
              Strings.strRegisterToCreateAccount,
              style: TextStyle(
                  fontFamily: FontFamily.poppinsRegular, fontSize: 16),
            ).paddingLeft(15),
            const SizedBox(
              height: 50,
            ),
            CommonTextfield(
              controller: loginBloc.reEmailController,
              hintText: Strings.email,
            ).paddingSymmetric(horizontal: 10, vertical: 15),
            CommonTextfield(
              controller: loginBloc.rePasswordController,
              hintText: Strings.password,
              obscure: true,
            ).paddingSymmetric(horizontal: 10, vertical: 5),
            CommonButton(
              onPressed: () {
                loginBloc.add(RegisterRequest(context));
              },
              text: Strings.strLogin,
              isLight: false,
            ).paddingSymmetric(horizontal: 10, vertical: 50),
            Center(
              child: Text.rich(TextSpan(children: [
                const TextSpan(
                  text: Strings.strAlreadyHaveAcc,
                  style: TextStyle(
                    fontFamily: FontFamily.poppinsMedium,
                  ),
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pop(context);
                    },
                  text: Strings.strLoginToContinue,
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
