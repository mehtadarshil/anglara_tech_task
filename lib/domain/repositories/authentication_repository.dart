import 'package:anglara_tech_task/domain/entities/login_request_params.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../entities/app_error.dart';

abstract class AuthenticationRepository {
  Future<Either<AppError, UserCredential>> loginUser(LoginEntity params);
  Future<Either<AppError, UserCredential>> registerUser(LoginEntity params);
}
