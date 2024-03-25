part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthenticatedState extends AuthState {
  final UserModel user;

  AuthenticatedState({required this.user});
}

final class UnauthenticatedState extends AuthState {}
