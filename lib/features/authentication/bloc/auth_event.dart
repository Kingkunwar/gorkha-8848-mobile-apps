part of 'auth_bloc.dart';

sealed class AuthEvent {}

class UserRegistrationEvent extends AuthEvent {
  final SignupModel userData;
  UserRegistrationEvent({
    required this.userData,
  });
}

class UserLoginEvent extends AuthEvent {
  final String email;
  final String password;
  UserLoginEvent({
    required this.email,
    required this.password,
  });
}

class AuthenticationCheckEvent extends AuthEvent {}
class LogoutEvent extends AuthEvent {}
