part of 'facebook_bloc.dart';

@immutable
abstract class FacebookEvent {}

class FacebookSubmit extends FacebookEvent {
  BuildContext context;
  FacebookSubmit({this.context});
}

class FacebookLogout extends FacebookEvent {
  BuildContext context;
  FacebookLogout({this.context});
}
