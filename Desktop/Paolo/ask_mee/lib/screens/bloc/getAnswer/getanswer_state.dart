part of 'getanswer_bloc.dart';

@immutable
abstract class GetanswerState {}

class GetanswerInitial extends GetanswerState {}

class GetanswerLoading extends GetanswerState {}

class GetanswerFetch extends GetanswerState {
  List answer;

  GetanswerFetch({this.answer});
}
