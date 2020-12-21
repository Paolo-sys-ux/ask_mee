part of 'facebook_bloc.dart';

@immutable
abstract class FacebookState {}

class FacebookInitial extends FacebookState {}

class FacebookLoading extends FacebookState {}

class FacebookDone extends FacebookState {}

class FacebookError extends FacebookState {
  final String errorMessage;

  FacebookError({this.errorMessage});
}
