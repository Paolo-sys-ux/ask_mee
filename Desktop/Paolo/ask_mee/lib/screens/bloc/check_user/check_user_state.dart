part of 'check_user_bloc.dart';

@immutable
abstract class CheckUserState {}

class CheckUserInitial extends CheckUserState {}

class CheckUserFetch extends CheckUserState {}
