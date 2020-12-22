import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

        await postRef.doc().set({
          "title": event.title,
          "body": event.body,
          "author": event.author,
          "uid": uid
        });
        yield CreateSubmit(submitMessage: 'Ask Already Posted');
      } catch (e) {
        print(e);
        yield CreateError(errorMessage: e.toString());
      }
    }
  }
}
