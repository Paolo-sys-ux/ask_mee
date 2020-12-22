part of 'profile_picture_bloc.dart';

@immutable
abstract class ProfilePictureEvent {}

class ProfileGet extends ProfilePictureEvent {
  ProfileGet();
}
