import 'package:anglara_tech_task/data/data_sources/authentication_remote_data_source.dart';
import 'package:anglara_tech_task/data/repositories/authentication_repository_impl.dart';
import 'package:anglara_tech_task/di/app_component_base.dart';
import 'package:anglara_tech_task/domain/entities/login_request_params.dart';
import 'package:anglara_tech_task/domain/usecase/auth/login_user.dart';
import 'package:anglara_tech_task/domain/usecase/auth/register_user.dart';
import 'package:anglara_tech_task/shared/constants/route_constants.dart';
import 'package:anglara_tech_task/shared/constants/storage_constants.dart';
import 'package:anglara_tech_task/shared/constants/strings.dart';
import 'package:anglara_tech_task/shared/utils/logger.dart';
import 'package:anglara_tech_task/shared/utils/snackbar.dart';
import 'package:anglara_tech_task/shared/utils/utility.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

part 'login_bloc_event.dart';
part 'login_bloc_state.dart';

class LoginBlocBloc extends Bloc<LoginBlocEvent, LoginBlocState> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController reEmailController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  LoginBlocBloc() : super(LoginBlocInitial()) {
    //login request function
    on<LoginRequest>((event, emit) async {
      if (emailController.text.isEmpty) {
        SnackBarUtil.showInSnackBar(event.context, Strings.strPleaseEnterEmail);
        return;
      } else if (!Utility.isEmail(emailController.text)) {
        SnackBarUtil.showInSnackBar(
            event.context, Strings.strPleaseEnterValidEmail);
        return;
      } else if (passwordController.text.isEmpty) {
        SnackBarUtil.showInSnackBar(
            event.context, Strings.strPleaseEnterPassword);
        return;
      }
      AppComponentBase.instance.showProgressDialog();
      var data = await LoginUserUseCase(AuthenticationRepositoryImpl(
              AuthenticationRemoteDataSourceImpl(_firebaseAuth)))
          .call(LoginEntity(
              email: emailController.text, password: passwordController.text));
      data.fold((l) {
        AppComponentBase.instance.hideProgressDialog();
        SnackBarUtil.showInSnackBar(event.context, Strings.loginFaild);
        Logger.prints(l);
      }, (r) async {
        if (r.user != null) {
          GetStorage()
              .write(StorageConstants.userId, r.user?.uid)
              .then((value) {
            AppComponentBase.instance.hideProgressDialog();
            Navigator.pushNamedAndRemoveUntil(
                event.context, RouteList.homeScreen, (route) => false);
          });
        } else {
          AppComponentBase.instance.hideProgressDialog();
          SnackBarUtil.showInSnackBar(event.context, Strings.loginFaild);
        }
      });
    });

    //registration request function
    on<RegisterRequest>((event, emit) async {
      if (emailController.text.isEmpty) {
        SnackBarUtil.showInSnackBar(event.context, Strings.strPleaseEnterEmail);
        return;
      } else if (!Utility.isEmail(emailController.text)) {
        SnackBarUtil.showInSnackBar(
            event.context, Strings.strPleaseEnterValidEmail);
        return;
      } else if (passwordController.text.isEmpty) {
        SnackBarUtil.showInSnackBar(
            event.context, Strings.strPleaseEnterPassword);
        return;
      }
      AppComponentBase.instance.showProgressDialog();
      var data = await RegisterUserUseCase(AuthenticationRepositoryImpl(
              AuthenticationRemoteDataSourceImpl(_firebaseAuth)))
          .call(LoginEntity(
              email: emailController.text, password: passwordController.text));
      data.fold((l) {
        AppComponentBase.instance.hideProgressDialog();
        SnackBarUtil.showInSnackBar(event.context, Strings.registrationFaild);
        Logger.prints(l);
      }, (r) async {
        if (r.user != null) {
          GetStorage()
              .write(StorageConstants.userId, r.user?.uid)
              .then((value) {
            AppComponentBase.instance.hideProgressDialog();
            Navigator.pushNamedAndRemoveUntil(
                event.context, RouteList.homeScreen, (route) => false);
          });
        } else {
          AppComponentBase.instance.hideProgressDialog();
          SnackBarUtil.showInSnackBar(event.context, Strings.registrationFaild);
        }
      });
    });
  }
}
