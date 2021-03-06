import 'package:ask_mee/constants/styles.dart';
import 'package:ask_mee/screens/bloc/edit_profile/edit_profile_bloc.dart';
import 'package:ask_mee/screens/bloc/getUserData/getuserdata_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController usernameCont = TextEditingController();
  TextEditingController fullnameCont = TextEditingController();
  TextEditingController bioCont = TextEditingController();
  String username, fullname, bio;

  void disposed() {
    usernameCont.clear();
    fullnameCont.clear();
    bioCont.clear();
  }

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final form = FormGroup({
    'username': FormControl(validators: [Validators.required]),
    'fullname': FormControl(validators: [Validators.required]),
    'bio': FormControl(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetuserdataBloc>(context).add(getUserData());
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          'Edit Profile',
          style: kTextButton.copyWith(color: Color(0xFF514A43)),
        ),
      ),
      body: BlocBuilder<GetuserdataBloc, GetuserdataState>(
        builder: (context, state) {
          if (state is GetuserdataLoading) {
            return SpinKitFadingCircle(
              color: Colors.grey,
              size: 50.0,
            );
          } else if (state is GetuserdataFetch) {
            username = (state.data[0]["username"]);
            fullname = (state.data[0]["fullname"]);
            bio = (state.data[0]["bio"]);

            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      initialValue: username,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter your username';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        username = value;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.title,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        labelText: 'Username',
                        hintText: 'ex. Juan Bhoxz',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: fullname,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter your full name';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        fullname = value;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.title,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        labelText: 'Full name',
                        hintText: 'ex. Juan Dela Cruz',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: bio,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter your bio';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        bio = value;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.title,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        labelText: 'Bio',
                        hintText: 'ex. Mataas tumalon boss mapagmahal',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<EditProfileBloc, EditProfileState>(
                      builder: (context, state) {
                        if (state is EditProfileLoading) {
                          return SpinKitFadingCircle(
                            color: Colors.grey,
                            size: 50.0,
                          );
                        } else if (state is EditProfileDone) {
                        } else if (state is EditProfileError) {}
                        return Text('');
                      },
                    ),
                    InkWell(
                      onTap: () => {
                        if (_formKey.currentState.validate())
                          {
                            BlocProvider.of<EditProfileBloc>(context).add(
                                EditProfileSubmit(
                                    username: username,
                                    fullname: fullname,
                                    bio: bio,
                                    key: _scaffoldKey,
                                    context: context)),
                            disposed(),
                          }
                      },
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Submit',
                              textAlign: TextAlign.center,
                              style: kTextButton.copyWith(
                                  color: Colors.white, fontSize: 22),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            );
          }
          return Text('');
        },
      ),
    );
  }
}
