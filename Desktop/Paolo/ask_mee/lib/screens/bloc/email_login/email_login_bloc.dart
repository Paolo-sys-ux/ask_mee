import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'email_login_event.dart';
part 'email_login_state.dart';

class EmailLoginBloc extends Bloc<EmailLoginEvent, EmailLoginState> {
  EmailLoginBloc() : super(EmailLoginInitial());
  final _auth = FirebaseAuth.instance;

  @override
  Stream<EmailLoginState> mapEventToState(
    EmailLoginEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is Submit) {
      print(event.email);
      print(event.password);
      yield EmailLoginLoading(loadingMessage: 'Please wait...');
      await Future.delayed(const Duration(milliseconds: 3000), () {});

      try {
        final user = await _auth.signInWithEmailAndPassword(
            email: event.email, password: event.password);

        if (user != null) {
          print('pasok na');
          Navigator.popAndPushNamed(event.context, '/navigationbar');
          yield EmailLoginSubmit(submitMessage: 'Login Successfully');
        }
      } catch (e) {
        print(e);

        yield EmailLoginError(errorMessage: e.toString());
      }
    }
  }
}
