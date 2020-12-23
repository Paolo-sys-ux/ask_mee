import 'dart:async';

import 'package:ask_mee/screens/bloc/getUserData/getuserdata_bloc.dart';
import 'package:ask_mee/screens/bloc/profile_picture/profile_picture_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial());
  final _auth = FirebaseAuth.instance;

  @override
  Stream<EditProfileState> mapEventToState(
    EditProfileEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is EditProfileSubmit) {
      yield EditProfileLoading();

      try {
        var user = _auth.currentUser;
        var uid = user.uid;
        final usersRef = FirebaseFirestore.instance.collection('users');
        final userProRef =
            FirebaseFirestore.instance.collection('profile_photo');

        await usersRef.doc(uid).update({
          "username": event.username,
          "fullname": event.fullname,
          "bio": event.bio
        });

        await userProRef.doc(uid).update({
          "username": event.username,
          "fullname": event.fullname,
          "bio": event.bio
        });

        yield EditProfileDone(doneMessage: 'Update Completed');
        final snackBar = SnackBar(
          content: Text('Added data Successfuly'),
        );
        event._scaffoldKey.currentState.showSnackBar(snackBar);
        BlocProvider.of<GetuserdataBloc>(event.context).add(getUserData());
        BlocProvider.of<ProfilePictureBloc>(event.context).add(ProfileGet());
      } catch (e) {
        print(e);
        yield EditProfileError(errorMessage: e.toString());
        final snackBar = SnackBar(
          content: Text('Error in Updating'),
        );
        event._scaffoldKey.currentState.showSnackBar(snackBar);
      }
    }
  }
}
