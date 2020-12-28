part of 'getuserpost_bloc.dart';

@immutable
abstract class GetuserpostEvent {
  Object get uid => null;
}

class DisplayUserData extends GetuserpostEvent {
  DisplayUserData();
}
