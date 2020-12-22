import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial());

  final _auth = FirebaseAuth.instance;

  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is CreateAccount) {
      print(event.email);
      print(event.password);
      yield SignupLoading(loadingMessage: 'Please wait...');
      await Future.delayed(const Duration(milliseconds: 3000), () {});

      try {
        final newUser = await _auth.createUserWithEmailAndPassword(
            email: event.email, password: event.password);

        var user = _auth.currentUser;
        var uid = user.uid;

        final usersRef = FirebaseFirestore.instance.collection('users');
        await usersRef
            .doc(uid)
            .set({"uid": uid, "email": event.email, "acct_name": 'email'});

        //fcm
        final firestoreToken = FirebaseFirestore.instance;
        final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
        _firebaseMessaging.getToken().then((token) {
          firestoreToken
              .collection('tokens')
              .doc(uid)
              .set({'token': token, 'uid': uid});
        });

        if (newUser != null) {
          print('Account created');
          Navigator.pushNamed(event.context, '/loginscreen');
          yield SignupDone(doneMessage: 'Account Created');
        }
      } catch (e) {
        print(e);
        yield SignupError(errorMessage: e.toString());
      }
    }
  }
}
