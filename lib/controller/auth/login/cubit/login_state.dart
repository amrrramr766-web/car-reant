part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final int userID;
  final String name;
  final String email;

  LoginSuccess(this.userID, this.name, this.email);
}

final class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure(this.errorMessage);
}
