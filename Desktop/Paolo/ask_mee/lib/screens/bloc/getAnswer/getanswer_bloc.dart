import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'getanswer_event.dart';
part 'getanswer_state.dart';

class GetanswerBloc extends Bloc<GetanswerEvent, GetanswerState> {
  GetanswerBloc() : super(GetanswerInitial());
  final _auth = FirebaseAuth.instance;

  @override
  Stream<GetanswerState> mapEventToState(
    GetanswerEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is GetAnswer) {
      try {
        var user = _auth.currentUser;
        var uid = user.uid;
        final usersRef = FirebaseFirestore.instance.collection('answers');

        final QuerySnapshot snapshot =
            await usersRef.where("uid", isEqualTo: uid).get();

        snapshot.documents.forEach((DocumentSnapshot doc) {
          print(doc.data());
          print(doc.documentID);
        });

        yield GetanswerFetch(answer: snapshot.docs);
      } catch (e) {}
    }
  }
}
