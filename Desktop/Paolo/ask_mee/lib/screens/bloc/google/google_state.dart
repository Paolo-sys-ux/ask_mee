part of 'google_bloc.dart';

@immutable
abstract class GoogleState {}

class GoogleInitial extends GoogleState {}

class GoogleLoading extends GoogleState {}

class GoogleError extends GoogleState {
  final String errorMessage;

  GoogleError({this.errorMessage});
}
