part of 'check_user_bloc.dart';

@immutable
abstract class CheckUserEvent {}

class Check extends CheckUserEvent {
  BuildContext context;
  Check({this.context});
}
