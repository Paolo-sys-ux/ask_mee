import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'getuserpost_event.dart';
part 'getuserpost_state.dart';

class GetuserpostBloc extends Bloc<GetuserpostEvent, GetuserpostState> {
  GetuserpostBloc() : super(GetuserpostInitial());
  final _auth = FirebaseAuth.instance;

  @override
  Stream<GetuserpostState> mapEventToState(
    GetuserpostEvent event,
  ) async* {
    // TODO: implement mapEventToState

    yield GetuserpostLoading(loadingMessage: 'Loading...');
    if (event is DisplayUserData) {
      try {
        var user = _auth.currentUser;
        var uid = user.uid;
        final usersRef = FirebaseFirestore.instance.collection('post');

        final QuerySnapshot snapshot =
            await usersRef.where("uid", isEqualTo: uid).get();

        snapshot.documents.forEach((DocumentSnapshot doc) {
          print(doc.data());
          print(doc.documentID);
        });

        yield GetuserpostFetch(post: snapshot.docs);
      } catch (e) {}
    }
  }
}
