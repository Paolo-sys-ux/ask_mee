import 'package:ask_mee/constants/styles.dart';
import 'package:ask_mee/screens/bloc/signup/signup_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String email, password;

  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final form = FormGroup({
    'email': FormControl(validators: [Validators.required]),
    'password': FormControl(validators: [Validators.required]),
  });

  void disposed() {
    emailCont.clear();
    passwordCont.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Sign up",
          style: kTextButton.copyWith(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                width: 350,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 3), // changes position of shadow
                      )
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Create account',
                        style: kTextButton.copyWith(fontSize: 22),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: emailCont,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter you email';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  email = value;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  labelText: 'Enter email',
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                controller: passwordCont,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  password = value;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                  ),
                                  labelText: 'Enter password',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              BlocBuilder<SignupBloc, SignupState>(
                                builder: (context, state) {
                                  if (state is SignupLoading) {
                                    return Column(
                                      children: [
                                        SpinKitFadingCircle(
                                          color: Colors.grey,
                                          size: 50.0,
                                        ),
                                        Text('Please wait...'),
                                      ],
                                    );
                                  } else if (state is SignupError) {
                                    return Text('${state.errorMessage}');
                                  }
                                  return (Text(''));
                                },
                              ),
                              InkWell(
                                onTap: () {
                                  if (_formKey.currentState.validate()) {
                                    BlocProvider.of<SignupBloc>(context).add(
                                      CreateAccount(
                                          email: email,
                                          password: password,
                                          context: context),
                                    );
                                    disposed();
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(0),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      'I-SUBMIT',
                                      style: kTextButton.copyWith(
                                          fontSize: 14, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              InkWell(
                                onTap: () => Navigator.popAndPushNamed(
                                    context, '/loginscreen'),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text('Mag sign-in'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
