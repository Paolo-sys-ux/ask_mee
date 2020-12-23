import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'getuserdata_event.dart';
part 'getuserdata_state.dart';

class GetuserdataBloc extends Bloc<GetuserdataEvent, GetuserdataState> {
  GetuserdataBloc() : super(GetuserdataInitial());
  final _auth = FirebaseAuth.instance;

  @override
  Stream<GetuserdataState> mapEventToState(
    GetuserdataEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is getUserData) {
      yield GetuserdataLoading();

      try {
        var user = _auth.currentUser;
        var uid = user.uid;
        final usersRef = FirebaseFirestore.instance.collection('users');

        final QuerySnapshot snapshot =
            await usersRef.where("uid", isEqualTo: uid).get();

        snapshot.documents.forEach((DocumentSnapshot doc) {
          print(doc.data());
          print(doc.documentID);
        });

        yield GetuserdataFetch(data: snapshot.docs);
      } catch (e) {}
    }
  }
}
