part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginSuccess extends AuthState {}

final class Loginloding extends AuthState {}

final class LoginFailure extends AuthState {
 final String errtext;
  LoginFailure({required this.errtext});

}
final class RegisterInitial extends AuthState {}

final class RegisterSuccess extends AuthState {}

final class Registerloding extends AuthState {}


final class RegisterFailure extends AuthState {
 final String errtext;
  RegisterFailure({required this.errtext});
}
