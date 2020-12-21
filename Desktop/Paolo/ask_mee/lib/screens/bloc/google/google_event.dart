part of 'google_bloc.dart';

@immutable
abstract class GoogleEvent {}

class GoogleSubmit extends GoogleEvent {
  BuildContext context;

  GoogleSubmit({this.context});
}
