import 'package:ask_mee/constants/styles.dart';
import 'package:flutter/material.dart';
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

  final form = FormGroup({
    'username': FormControl(validators: [Validators.required]),
    'fullname': FormControl(validators: [Validators.required]),
    'bio': FormControl(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: usernameCont,
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
                controller: fullnameCont,
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
                controller: bioCont,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter your full name';
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
              InkWell(
                onTap: () => {
                  if (_formKey.currentState.validate())
                    {
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
      ),
    );
  }
}
