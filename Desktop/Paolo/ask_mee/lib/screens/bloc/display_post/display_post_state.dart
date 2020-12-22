part of 'display_post_bloc.dart';

@immutable
abstract class DisplayPostState {}

class DisplayPostInitial extends DisplayPostState {}

class DisplayPostLoading extends DisplayPostState {
  final String loadingMessage;

  DisplayPostLoading({this.loadingMessage});
}

class DisplayPostFetch extends DisplayPostState {
  List post;
  DisplayPostFetch(this.post);
}

class DisplayPostDone extends DisplayPostState {}

class DisplayPostError extends DisplayPostState {
  final String errorMessage;

  DisplayPostError({this.errorMessage});
}
