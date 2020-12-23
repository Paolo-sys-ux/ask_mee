part of 'edit_profile_bloc.dart';

@immutable
abstract class EditProfileEvent {}

class EditProfileSubmit extends EditProfileEvent {
  final String username, fullname, bio;
  GlobalKey key = GlobalKey<ScaffoldState>();
  BuildContext context;

  EditProfileSubmit(
      {this.username, this.fullname, this.bio, this.key, this.context});

  get _scaffoldKey => key;
}
