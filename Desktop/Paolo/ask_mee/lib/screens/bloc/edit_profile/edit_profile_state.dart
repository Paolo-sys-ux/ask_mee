part of 'edit_profile_bloc.dart';

@immutable
abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileDone extends EditProfileState {
  final String doneMessage;

  EditProfileDone({this.doneMessage});
}

class EditProfileError extends EditProfileState {
  final String errorMessage;

  EditProfileError({this.errorMessage});
}
