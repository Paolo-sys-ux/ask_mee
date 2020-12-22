part of 'create_bloc.dart';

@immutable
abstract class CreateEvent {}

class Submit extends CreateEvent {
  final String title, body, author;

  Submit({this.title, this.body, this.author});
}
