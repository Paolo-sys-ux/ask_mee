part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent {}

class CreateAccount extends SignupEvent {
  final String email, password;
  BuildContext context;

  CreateAccount({this.email, this.password, this.context});
}
