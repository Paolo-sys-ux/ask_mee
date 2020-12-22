import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as basename;

part 'upload_image_event.dart';
part 'upload_image_state.dart';

class UploadImageBloc extends Bloc<UploadImageEvent, UploadImageState> {
  UploadImageBloc() : super(UploadImageInitial());

  final _auth = FirebaseAuth.instance;

  @override
  Stream<UploadImageState> mapEventToState(
    UploadImageEvent event,
  ) async* {
    // TODO: implement mapEventToState

    if (event is UploadImage) {
      yield UploadImageLoading();

      try {
        String _fileName = basename.basename(event.image.path);
        Reference firebaseStorageRef =
            FirebaseStorage.instance.ref().child('uploads/$_fileName');
        UploadTask uploadTask = firebaseStorageRef.putFile(event.image);

        TaskSnapshot taskSnapshot = await uploadTask;
        taskSnapshot.ref.getDownloadURL().then(
              (value) => print("Done: $value"),
            );

        yield UploadImageDone();
        final snackBar = SnackBar(
          content: Text('Upload Successfully'),
        );
        // event._scaffoldKey.currentState.showSnackBar(snackBar);

        //saving in cloud firestore
        if (event.image != null) {
          Reference ref = FirebaseStorage.instance.ref();
          TaskSnapshot addImg =
              await ref.child("image/img").putFile(event.image);

          var user = _auth.currentUser;
          var uid = user.uid;

          if (addImg != null) {
            final String downloadUrl = await addImg.ref.getDownloadURL();
            await FirebaseFirestore.instance
                .collection("profile_photo")
                .doc(uid)
                .set({"url": downloadUrl, "name": _fileName, "uid": uid});
          }

          //Fcm
          try {
            var postUrl = "https://fcm.googleapis.com/fcm/send";

            var token =
                'fstrR1nORLSB8VV-rQJSfX:APA91bF3kZZzbT9A6vClZrhyntGERRgyt8Hsa7JlXlFdTtM_a6Oh7Np4VPKyshCanUfwkh_qw_AZto6MBJzJre3O9MqzEw9_GABVcib065D1lKoNnmShIRQ9X63BJqPWNcP9D5E3_ikG';
            print(token);
            final data = {
              "notification": {
                "body": "The Admin change Profile Picture",
                "title": "Profile Picture"
              },
              "priority": "high",
              "data": {
                "click_action": "FLUTTER_NOTIFICATION_CLICK",
                "id": "1",
                "status": "done"
              },
              "to": "$token"
            };

            final headers = {
              'Accept': "application/json",
              'Authorization':
                  'key = AAAAfdcO-Ps:APA91bHkPFJ63MU4Z7Ncm9c-dSGH2jYVAW7mCIwO9LQU80VFzrLtqx8WQaIpXszMkfreM1iWmlE4ABQc8w3-lI9VmtQ_o3ECAu2IdLEgAD5_7ydbEh-UnFayCxQfKEMZgXxjW347akve',
            };

            BaseOptions options = new BaseOptions(
              connectTimeout: 5000,
              receiveTimeout: 3000,
              headers: headers,
            );

            try {
              final response =
                  await Dio(options).post(postUrl, data: json.encode(data));

              if (response.statusCode == 200) {
                print('Notif sended');
              } else {
                print('notification sending failed');
                // on failure do sth
              }
            } catch (e) {
              print('exception $e');
            }
          } catch (e) {}
        }
      } catch (e) {
        print(e);
        yield UploadImageError();
        final snackBar = SnackBar(
          content: Text('Failed to upload'),
        );
        // event._scaffoldKey.currentState.showSnackBar(snackBar);
      }
    }
  }
}
