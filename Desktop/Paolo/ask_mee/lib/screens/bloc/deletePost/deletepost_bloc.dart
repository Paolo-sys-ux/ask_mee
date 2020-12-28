import 'dart:async';

import 'package:ask_mee/screens/bloc/getUserPost/getuserpost_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'deletepost_event.dart';
part 'deletepost_state.dart';

class DeletepostBloc extends Bloc<DeletepostEvent, DeletepostState> {
  DeletepostBloc() : super(DeletepostInitial());

  @override
  Stream<DeletepostState> mapEventToState(
    DeletepostEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is Delete) {
      print(event.uid.toString());

      yield DeletepostLoading(loadingMessage: 'Deleting...');

      try {
        final blogRef = FirebaseFirestore.instance.collection('post');

        await blogRef.doc(event.uid).delete();

        BlocProvider.of<GetuserpostBloc>(event.context).add(DisplayUserData());

        yield DeletepostDone();
      } catch (e) {
        print(e);
        yield DeletepostError();
      }
    }
  }
}
