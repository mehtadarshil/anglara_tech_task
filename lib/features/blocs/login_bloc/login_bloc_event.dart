part of 'login_bloc_bloc.dart';

class LoginBlocEvent extends Equatable {
  const LoginBlocEvent();

  @override
  List<Object> get props => [];
}

class LoginRequest extends LoginBlocEvent {
  final BuildContext context;

  @override
  List<Object> get props => [context];

  const LoginRequest(this.context);
}

class RegisterRequest extends LoginBlocEvent {
  final BuildContext context;

  @override
  List<Object> get props => [context];

  const RegisterRequest(this.context);
}
