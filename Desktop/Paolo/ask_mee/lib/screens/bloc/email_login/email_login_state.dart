part of 'email_login_bloc.dart';

@immutable
abstract class EmailLoginState {}

class EmailLoginInitial extends EmailLoginState {}

class EmailLoginLoading extends EmailLoginState {
  final String loadingMessage;

  EmailLoginLoading({this.loadingMessage});
}

class EmailLoginSubmit extends EmailLoginState {
  final String submitMessage;

  EmailLoginSubmit({this.submitMessage});
}

class EmailLoginDone extends EmailLoginState {}

class EmailLoginError extends EmailLoginState {
  final String errorMessage;

  EmailLoginError({this.errorMessage});
}
