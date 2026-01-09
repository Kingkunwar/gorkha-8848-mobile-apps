part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

class UserLoggedInState extends AuthState {
  final SignupResponseModel signupResponse;
  UserLoggedInState({
    required this.signupResponse,
  });
}

class UserLoggingInState extends AuthState {}

class AuthFailureState extends AuthState {
  final Failure failure;

  AuthFailureState({
    required this.failure,
  });
}
