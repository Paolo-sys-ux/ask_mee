import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'profile_picture_event.dart';
part 'profile_picture_state.dart';

class ProfilePictureBloc
    extends Bloc<ProfilePictureEvent, ProfilePictureState> {
  ProfilePictureBloc() : super(ProfilePictureInitial());

  @override
  Stream<ProfilePictureState> mapEventToState(
    ProfilePictureEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is ProfileGet) {
      yield ProfilePictureLoading();

      try {
        final _auth = FirebaseAuth.instance;
        final usersRef = FirebaseFirestore.instance.collection('profile_photo');

        var user = _auth.currentUser;
        var uid = user.uid;

        final QuerySnapshot snapshot =
            await usersRef.where("uid", isEqualTo: uid).get();

        snapshot.documents.forEach((DocumentSnapshot doc) {
          print(doc.data());
          print(doc.documentID);
        });

        yield ProfilePictureFetch(profile: snapshot.docs);
      } catch (e) {}
    }
  }
}
