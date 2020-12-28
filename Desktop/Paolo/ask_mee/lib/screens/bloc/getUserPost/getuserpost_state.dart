part of 'getuserpost_bloc.dart';

@immutable
abstract class GetuserpostState {}

class GetuserpostInitial extends GetuserpostState {}

class GetuserpostLoading extends GetuserpostState {
  final String loadingMessage;

  GetuserpostLoading({this.loadingMessage});
}

class GetuserpostFetch extends GetuserpostState {
  List post;
  GetuserpostFetch({this.post});
}

class GetuserpostDone extends GetuserpostState {}

class GetuserpostError extends GetuserpostState {
  final String errorMessage;

  GetuserpostError({this.errorMessage});
}

//delete state
class DeleteLoading extends GetuserpostState {
  final String loadingMessage;
  final List deleteBlog;

  DeleteLoading({this.deleteBlog, this.loadingMessage});
}

class DeleteDone extends GetuserpostState {
  final String doneMessage;

  DeleteDone({this.doneMessage});
}

class DeleteError extends GetuserpostState {
  final String errorMessage;

  DeleteError({this.errorMessage});
}
