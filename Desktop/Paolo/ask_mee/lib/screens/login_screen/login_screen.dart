import 'package:ask_mee/constants/styles.dart';
import 'package:ask_mee/screens/bloc/email_login/email_login_bloc.dart';
import 'package:ask_mee/screens/bloc/facebook/facebook_bloc.dart';
import 'package:ask_mee/screens/bloc/google/google_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          'Ask Mee',
          style: kTextButton.copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    BlocBuilder<FacebookBloc, FacebookState>(
                      builder: (context, state) {
                        if (state is FacebookLoading) {
                          return CircularProgressIndicator();
                        } else if (state is FacebookDone) {
                          return SizedBox.shrink();
                        } else if (state is FacebookError) {
                          return Text('Error Signin Facebook');
                        }
                        return SizedBox.shrink();
                      },
                    ),
                    BlocBuilder<GoogleBloc, GoogleState>(
                      builder: (context, state) {
                        if (state is GoogleLoading) {
                          return CircularProgressIndicator();
                        } else if (state is GoogleError) {
                          return Text('Error Signin Google');
                        }
                        return Text('');
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Center(
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
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  )
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Text(
                                    'Mag Login',
                                    style: kTextButton.copyWith(fontSize: 22),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            controller: emailCont,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Please enter your email';
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
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
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
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          BlocBuilder<EmailLoginBloc,
                                              EmailLoginState>(
                                            builder: (context, state) {
                                              if (state is EmailLoginLoading) {
                                                return Column(
                                                  children: [
                                                    SpinKitFadingCircle(
                                                      color: Colors.grey,
                                                      size: 50.0,
                                                    ),
                                                    Text('Please wait...'),
                                                  ],
                                                );
                                              } else if (state
                                                  is EmailLoginSubmit) {
                                                return Text(
                                                  '${state.submitMessage}',
                                                );
                                              }

                                              if (state is EmailLoginError) {
                                                return Text(
                                                    '${state.errorMessage}');
                                              }
                                              return (Text(''));
                                            },
                                          ),
                                          Card(
                                            elevation: 2,
                                            child: InkWell(
                                              onTap: () {
                                                if (_formKey.currentState
                                                    .validate()) {
                                                  BlocProvider.of<
                                                              EmailLoginBloc>(
                                                          context)
                                                      .add(Submit(
                                                    email: email,
                                                    password: password,
                                                    context: context,
                                                  ));
                                                  disposed();
                                                }
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(0),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Text(
                                                    'I-SUBMIT',
                                                    style: kTextButton.copyWith(
                                                        fontSize: 14,
                                                        color: Colors.white),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, '/signupscreen');
                                            },
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text('Mag sign-up'),
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
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Card(
                        elevation: 3,
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<GoogleBloc>(context)
                                .add(GoogleSubmit(context: context));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            color: Colors.white,
                            child: Center(
                              child: Text(
                                'Sign in with Google',
                                style: kTextButton.copyWith(
                                    color: Colors.black, fontSize: 22),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Card(
                        elevation: 3,
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<FacebookBloc>(context)
                                .add(FacebookSubmit(context: context));
                            // signInFB()
                            //     .whenComplete(() => Navigator.pushNamed(context, '/home'));
                          },
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            color: Colors.blueAccent,
                            child: Center(
                              child: Text(
                                'Login with Facebook',
                                style: kTextButton.copyWith(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
