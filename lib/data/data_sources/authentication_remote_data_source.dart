import 'package:anglara_tech_task/domain/entities/login_request_params.dart';
import 'package:anglara_tech_task/shared/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRemoteDataSource {
  Future<UserCredential> validateWithLogin(LoginEntity requestBody);
  Future<UserCredential> registerUser(LoginEntity requestBody);
}

class AuthenticationRemoteDataSourceImpl
    extends AuthenticationRemoteDataSource {
  final FirebaseAuth _auth;

  AuthenticationRemoteDataSourceImpl(this._auth);

  @override
  Future<UserCredential> validateWithLogin(LoginEntity requestBody) async {
    final response = await _auth.signInWithEmailAndPassword(
      email: requestBody.email!,
      password: requestBody.password!,
    );
    Logger.prints(response.user?.uid);
    return response;
  }

  @override
  Future<UserCredential> registerUser(LoginEntity requestBody) async {
    final response = await _auth.createUserWithEmailAndPassword(
      email: requestBody.email!,
      password: requestBody.password!,
    );
    Logger.prints(response.user?.uid);
    return response;
  }
}
