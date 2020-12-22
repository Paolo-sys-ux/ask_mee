part of 'edit_profile_bloc.dart';

@immutable
abstract class EditProfileEvent {}

class EditProfileSubmit extends EditProfileEvent {
  final String username, fullname, bio;

  EditProfileSubmit({this.username, this.fullname, this.bio});
}
