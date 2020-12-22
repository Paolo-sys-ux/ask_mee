part of 'edit_profile_bloc.dart';

@immutable
abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {
  final String loadingMessage;

  EditProfileLoading(this.loadingMessage);
}
