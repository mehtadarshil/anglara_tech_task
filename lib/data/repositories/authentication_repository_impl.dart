import 'dart:io';
import 'package:anglara_tech_task/domain/entities/login_request_params.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/app_error.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../core/unathorised_exception.dart';
import '../data_sources/authentication_remote_data_source.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;

  AuthenticationRepositoryImpl(
    this._authenticationRemoteDataSource,
  );

  @override
  Future<Either<AppError, UserCredential>> loginUser(LoginEntity params) async {
    try {
      final validateWithLoginToken =
          await _authenticationRemoteDataSource.validateWithLogin(params);
      if (validateWithLoginToken.user != null) {
        return Right(validateWithLoginToken);
      }
      return const Left(AppError(AppErrorType.sessionDenied));
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(AppErrorType.unauthorised));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, UserCredential>> registerUser(
      LoginEntity params) async {
    try {
      final validateWithLoginToken =
          await _authenticationRemoteDataSource.registerUser(params);
      if (validateWithLoginToken.user != null) {
        return Right(validateWithLoginToken);
      }
      return const Left(AppError(AppErrorType.sessionDenied));
    } on SocketException {
      return const Left(AppError(AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(AppErrorType.unauthorised));
    } on Exception {
      return const Left(AppError(AppErrorType.api));
    }
  }
}
