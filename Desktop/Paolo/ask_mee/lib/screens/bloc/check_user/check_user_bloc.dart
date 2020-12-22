import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'check_user_event.dart';
part 'check_user_state.dart';

class CheckUserBloc extends Bloc<CheckUserEvent, CheckUserState> {
  CheckUserBloc() : super(CheckUserInitial());
  final _auth = FirebaseAuth.instance;

  @override
  Stream<CheckUserState> mapEventToState(
    CheckUserEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is Check) {
      if (_auth == null) {
        print('pasok na');
        Navigator.popAndPushNamed(event.context, '/navigationbar');
      }
      yield CheckUserFetch();
    }
  }
}
