part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthInitial extends AuthState {}

class FetchGovernoratesLoading extends AuthState {
  final bool isLogin;

  FetchGovernoratesLoading({required this.isLogin});
}

class FetchGovernoratesFailure extends AuthState {
  final String? failure;

  FetchGovernoratesFailure({required this.failure});
}

class FetchGovernoratesSuccess extends AuthState {
  final bool isLogin;

  FetchGovernoratesSuccess({required this.isLogin});
}

class SendOTPLoading extends AuthState {}

class SendOTPFailure extends AuthState {
  final String? failure;

  SendOTPFailure({required this.failure});
}

class SendOTPSuccess extends AuthState {}

class LoginLoading extends AuthState {}

class LoginFailure extends AuthState {
  final String? failure;

  LoginFailure({required this.failure});
}

class LoginSuccess extends AuthState {}

class LogoutLoading extends AuthState {}

class LogoutSuccess extends AuthState {}

class LogoutFailure extends AuthState {
  final String? failure;

  LogoutFailure({required this.failure});
}

class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {}

class RegisterFailure extends AuthState {
  final String? failure;

  RegisterFailure({required this.failure});
}
