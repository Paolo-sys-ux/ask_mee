import 'dart:io';

import 'package:ask_mee/constants/styles.dart';
import 'package:ask_mee/screens/bloc/profile_picture/profile_picture_bloc.dart';
import 'package:ask_mee/screens/bloc/upload_image/upload_image_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String messageTitle = "No notifications";
  String notificationAlert = "Alert";

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  File _image;
  final picker = ImagePicker();

  Future getImageGallery() async {
    Navigator.pop(context);
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxHeight: 600, maxWidth: 275);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImage() async {
    Navigator.pop(context);
    final pickedFile = await picker.getImage(
        source: ImageSource.camera, maxHeight: 600, maxWidth: 275);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: Text('Create Post'),
            children: [
              SimpleDialogOption(
                child: Text('Photo with Camera'),
                onPressed: () {
                  getImage();
                },
              ),
              SimpleDialogOption(
                child: Text('Photo in gallery'),
                onPressed: () {
                  getImageGallery();
                },
              ),
              SimpleDialogOption(
                child: Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  //for fcm
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _firebaseMessaging.configure(
      onMessage: (message) async {
        setState(() {
          messageTitle = message["notification"]["title"];
          notificationAlert = "New Notification Alert";
        });
      },
      onResume: (message) async {
        setState(() {
          messageTitle = message["data"]["title"];
          notificationAlert = "Application opened from Notification";
        });
      },
    );
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfilePictureBloc>(context).add(ProfileGet());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Account User',
          style: kTextButton.copyWith(color: Color(0xFF514A43)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<ProfilePictureBloc, ProfilePictureState>(
              builder: (context, state) {
                if (state is ProfilePictureLoading) {
                  return SpinKitFadingCircle(
                    color: Colors.grey,
                    size: 50.0,
                  );
                } else if (state is ProfilePictureFetch) {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        _image == null
                            ? Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 4,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    selectImage(context);
                                  },
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(150)),
                                    child: Image.network(
                                      "${state.profile[0]['url']}",
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 4,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    selectImage(context);
                                  },
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(150)),
                                    child: Image.file(
                                      _image,
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                        Text(
                          'Anonymous',
                          style: kTextButton.copyWith(fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  '0',
                                  style: kTextButton.copyWith(fontSize: 22),
                                ),
                                Text('Ask'),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '0',
                                  style: kTextButton.copyWith(fontSize: 22),
                                ),
                                Text('Answer'),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '0',
                                  style: kTextButton.copyWith(fontSize: 22),
                                ),
                                Text(
                                  'Likes',
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 70, left: 70, bottom: 10),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(0xFFD3D3D3),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            //uploadImageToFirebase(context);
                            BlocProvider.of<UploadImageBloc>(context).add(
                                UploadImage(image: _image, key: _scaffoldKey));
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 50, right: 50),
                                  child: Text(
                                    'Go',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              BlocBuilder<UploadImageBloc, UploadImageState>(
                                builder: (context, state) {
                                  if (state is UploadImageLoading) {
                                    return SpinKitFadingCircle(
                                      color: Colors.grey,
                                      size: 50.0,
                                    );
                                  } else if (state is UploadImageDone) {
                                  } else if (state is UploadImageError) {}
                                  return Text('');
                                },
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            //uploadImageToFirebase(context);
                            Navigator.pushNamed(context, '/editprofilescreen');
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, left: 50, right: 50),
                                  child: Text(
                                    'Edit Profile',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              BlocBuilder<UploadImageBloc, UploadImageState>(
                                builder: (context, state) {
                                  if (state is UploadImageLoading) {
                                    return SpinKitFadingCircle(
                                      color: Colors.grey,
                                      size: 50.0,
                                    );
                                  } else if (state is UploadImageDone) {
                                  } else if (state is UploadImageError) {}
                                  return Text('');
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    notificationAlert,
                                  ),
                                  Text(
                                    messageTitle,
                                    style: kTextButton,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Text('');
              },
            ),
          ],
        ),
      ),
    );
  }
}
