import 'dart:async';

import 'package:ask_mee/screens/bloc/getAnswer/getanswer_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'postanswer_event.dart';
part 'postanswer_state.dart';

class PostanswerBloc extends Bloc<PostanswerEvent, PostanswerState> {
  PostanswerBloc() : super(PostanswerInitial());
  final _auth = FirebaseAuth.instance;

  @override
  Stream<PostanswerState> mapEventToState(
    PostanswerEvent event,
  ) async* {
    // TODO: implement mapEventToState
    yield PostanswerLoading();

    if (event is PostAnswer) {
      try {
        var user = _auth.currentUser;
        var uid = user.uid;

        final usersRef = FirebaseFirestore.instance.collection('answers');
        await usersRef
            .doc()
            .set({"uid": uid, "postId": event.postId, "answer": event.body});
        yield PostanswerFetch();
        BlocProvider.of<GetanswerBloc>(event.context).add(GetAnswer());
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
