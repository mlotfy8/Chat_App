part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}
class LoginFaluier extends AuthState {
  String  errorMessage;

  LoginFaluier({required this.errorMessage});
}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class SinginInitial extends AuthState {}

class SinginSuccess extends AuthState {}

class SinginFaluier extends AuthState {}

class SinginLoading extends AuthState {}
