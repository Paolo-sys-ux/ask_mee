part of 'deletepost_bloc.dart';

@immutable
abstract class DeletepostState {}

class DeletepostInitial extends DeletepostState {}

class DeletepostLoading extends DeletepostState {
  final String loadingMessage;
  final List deleteBlog;

  DeletepostLoading({this.deleteBlog, this.loadingMessage});
}

class DeletepostDone extends DeletepostState {
  final String doneMessage;

  DeletepostDone({this.doneMessage});
}

class DeletepostError extends DeletepostState {
  final String errorMessage;

  DeletepostError({this.errorMessage});
}
