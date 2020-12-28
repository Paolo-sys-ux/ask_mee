part of 'deletepost_bloc.dart';

@immutable
abstract class DeletepostEvent {
  Object get uid => null;
}

class Delete extends DeletepostEvent {
  var uid;
  BuildContext context;

  Delete({this.uid, this.context});
}
