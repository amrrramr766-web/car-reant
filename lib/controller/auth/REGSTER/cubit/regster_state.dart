part of 'regster_cubit.dart';

@immutable
sealed class RegsterState {}

final class RegsterInitial extends RegsterState {}

final class RegsterLoading extends RegsterState {}

class RegsterSuccess extends RegsterState {
  final String name;
  final String email;
  final String password;
  final String phone;

  RegsterSuccess(this.password, this.name, this.email, this.phone);
}

final class RegsterFailure extends RegsterState {
  final String errorMessage;

  RegsterFailure(this.errorMessage);
}
