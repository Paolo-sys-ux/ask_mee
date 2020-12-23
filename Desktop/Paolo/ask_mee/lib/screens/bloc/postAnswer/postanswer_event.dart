part of 'postanswer_bloc.dart';

@immutable
abstract class PostanswerEvent {}

class PostAnswer extends PostanswerEvent {
  final String body;
  var postId;
  BuildContext context;

  PostAnswer({this.postId, this.body, this.context});
}
