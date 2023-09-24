import 'package:anglara_tech_task/domain/entities/app_error.dart';
import 'package:anglara_tech_task/domain/entities/login_request_params.dart';
import 'package:anglara_tech_task/domain/repositories/authentication_repository.dart';
import 'package:anglara_tech_task/domain/usecase/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterUserUseCase extends UseCase<UserCredential, LoginEntity> {
  final AuthenticationRepository _authenticationRepository;

  RegisterUserUseCase(this._authenticationRepository);

  @override
  Future<Either<AppError, UserCredential>> call(LoginEntity params) async =>
      _authenticationRepository.registerUser(params);
}
