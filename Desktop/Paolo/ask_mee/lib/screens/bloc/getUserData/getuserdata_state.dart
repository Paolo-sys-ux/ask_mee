part of 'getuserdata_bloc.dart';

@immutable
abstract class GetuserdataState {}

class GetuserdataInitial extends GetuserdataState {}

class GetuserdataLoading extends GetuserdataState {}

class GetuserdataFetch extends GetuserdataState {
  List data;
  GetuserdataFetch({this.data});
}
