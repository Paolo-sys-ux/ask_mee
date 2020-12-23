part of 'postanswer_bloc.dart';

@immutable
abstract class PostanswerState {}

class PostanswerInitial extends PostanswerState {}

class PostanswerLoading extends PostanswerState {}

class PostanswerFetch extends PostanswerState {
  List answer;

  PostanswerFetch({this.answer});
}

class PostanswerError extends PostanswerState {}
