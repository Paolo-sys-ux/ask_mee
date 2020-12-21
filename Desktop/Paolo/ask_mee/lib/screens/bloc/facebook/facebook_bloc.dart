import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:meta/meta.dart';

part 'facebook_event.dart';
part 'facebook_state.dart';

class FacebookBloc extends Bloc<FacebookEvent, FacebookState> {
  FacebookBloc() : super(FacebookInitial());
  final fbLogin = FacebookLogin();

  @override
  Stream<FacebookState> mapEventToState(
    FacebookEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is FacebookSubmit) {
      yield FacebookLoading();
      print(event.context);
      try {
        final FacebookLoginResult result = await fbLogin.logIn(["email"]);

        final String token = result.accessToken.token;
        final response = await Dio().get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
        final profile = jsonDecode(response.data);

        Navigator.pushNamed(event.context, '/navigationbar');

        print(profile);
      } catch (e) {
        print(e);

        yield FacebookError(errorMessage: 'Failed to Sign in');
      }
    } else if (event is FacebookLogout) {
      yield FacebookLoading();

      try {
        final FirebaseAuth _auth = FirebaseAuth.instance;

        await fbLogin.logOut();
        await _auth.signOut();

        await Future.delayed(const Duration(milliseconds: 5000), () {});
        Navigator.popAndPushNamed(event.context, '/navigationbar');
        yield FacebookDone();
      } catch (e) {
        print(e);
        print('yow');
      }
    }
  }
}
