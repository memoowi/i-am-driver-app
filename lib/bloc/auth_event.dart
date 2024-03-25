part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}


class AppStarted extends AuthEvent {}

class Signin extends AuthEvent {
  final String username;
  final String password;
  final BuildContext context;

  Signin(
      {required this.username, required this.password, required this.context});
}

class Signup extends AuthEvent {
  final BuildContext context;
  final String name;
  final String phoneNumber;
  final String email;
  final String password;

  Signup({
    required this.context,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.password,
  });
}

class Signout extends AuthEvent {
  final BuildContext context;

  Signout({required this.context});
}
