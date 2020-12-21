part of 'email_login_bloc.dart';

@immutable
abstract class EmailLoginEvent {}

class Submit extends EmailLoginEvent {
  final String email, password;
  BuildContext context;

  Submit({this.email, this.password, this.context});
}
