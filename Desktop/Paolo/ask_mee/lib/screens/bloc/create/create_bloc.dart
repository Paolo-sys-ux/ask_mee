import 'dart:async';
import 'dart:math';

import 'package:ask_mee/screens/bloc/display_post/display_post_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'create_event.dart';
part 'create_state.dart';

class CreateBloc extends Bloc<CreateEvent, CreateState> {
  CreateBloc() : super(CreateInitial());
  final _auth = FirebaseAuth.instance;

  @override
  Stream<CreateState> mapEventToState(
    CreateEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is Submit) {
      print(event.title);
      print(event.body);
      print(event.author);

      yield CreateLoading(loadingMessage: 'Wait a sec..', loading: false);
      await Future.delayed(const Duration(milliseconds: 3000), () {});

      try {
        final postRef = FirebaseFirestore.instance.collection('post');

        var user = _auth.currentUser;
        var uid = user.uid;

        Random random = new Random();
        int randomNumber = random.nextInt(999999999);

        //getting post id

        await postRef.doc().set({
          "title": event.title,
          "body": event.body,
          "author": event.author,
          "uid": uid,
          "postId": randomNumber,
        });

        yield CreateSubmit(submitMessage: 'Ask Already Posted');

        Navigator.popAndPushNamed(event.context, '/navigationbar');
      } catch (e) {
        print(e);
        yield CreateError(errorMessage: e.toString());
      }
    }
  }
}
