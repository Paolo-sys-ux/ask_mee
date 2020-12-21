part of 'signup_bloc.dart';

@immutable
abstract class SignupState {}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {
  final String loadingMessage;

  SignupLoading({this.loadingMessage});
}

class SignupDone extends SignupState {
  final String doneMessage;

  SignupDone({this.doneMessage});
}

class SignupError extends SignupState {
  final String errorMessage;

  SignupError({this.errorMessage});
}
