part of 'create_bloc.dart';

@immutable
abstract class CreateState {}

class CreateInitial extends CreateState {}

class CreateLoading extends CreateState {
  final bool loading;
  final String loadingMessage;

  CreateLoading({this.loading, this.loadingMessage});
}

class CreateSubmit extends CreateState {
  final submitMessage;

  CreateSubmit({this.submitMessage});
}

class CreateEmpty extends CreateState {
  final String title, body, author;

  CreateEmpty({this.title, this.body, this.author});
}

class CreateError extends CreateState {
  final errorMessage;

  CreateError({this.errorMessage});
}
