part of 'profile_picture_bloc.dart';

@immutable
abstract class ProfilePictureState {}

class ProfilePictureInitial extends ProfilePictureState {}

class ProfilePictureLoading extends ProfilePictureState {}

class ProfilePictureFetch extends ProfilePictureState {
  List profile;
  ProfilePictureFetch({this.profile});
}
