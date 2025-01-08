part of 'login_cubit.dart';

abstract class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSuccess extends LoginState {}

final class Loginloding extends LoginState {}

final class LoginFailure extends LoginState {
  String errtext;
  LoginFailure({required this.errtext});
}
