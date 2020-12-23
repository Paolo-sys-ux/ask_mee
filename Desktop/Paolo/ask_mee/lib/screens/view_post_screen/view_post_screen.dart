import 'package:ask_mee/constants/styles.dart';
import 'package:ask_mee/screens/bloc/display_post/display_post_bloc.dart';
import 'package:ask_mee/screens/bloc/getAnswer/getanswer_bloc.dart';
import 'package:ask_mee/screens/bloc/postAnswer/postanswer_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ViewPostScreen extends StatefulWidget {
  String title, author, body;
  ViewPostScreen({this.title, this.author, this.body});

  @override
  _ViewPostScreenState createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends State<ViewPostScreen> {
  TextEditingController bodyCont = TextEditingController();
  String body;
  var answer;

  final _formKey = GlobalKey<FormState>();
  final form = FormGroup({
    'bodyCont': FormControl(validators: [Validators.required]),
  });

  void disposed() {
    bodyCont.clear();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GetanswerBloc>(context).add(GetAnswer());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          'Answering Questions',
          style: kTextButton.copyWith(color: Color(0xFF514A43)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<DisplayPostBloc, DisplayPostState>(
              builder: (context, state) {
                if (state is DisplayPostLoading) {
                  return SpinKitFadingCircle(
                    color: Colors.grey,
                    size: 50.0,
                  );
                } else if (state is DisplayPostFetch) {
                  var postId = (state.post[0]['postId']);

                  return SingleChildScrollView(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(postId.toString()),
                            Text(
                              '${widget.title}',
                              style: kTextButton.copyWith(
                                  color: Colors.black, fontSize: 28),
                            ),
                            Row(
                              children: [
                                Text('Published by: '),
                                Text('${widget.author}'),
                              ],
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${widget.body}',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                            Divider(
                              height: 1,
                              thickness: 0.5,
                              color: Colors.grey,
                            ),

                            //get all answers
                            BlocBuilder<GetanswerBloc, GetanswerState>(
                              builder: (context, state) {
                                if (state is GetanswerLoading) {
                                  return Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SpinKitFadingCircle(
                                            color: Colors.grey,
                                            size: 50.0,
                                          ),
                                        ],
                                      ));
                                } else if (state is GetanswerFetch) {
                                  return Container(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: state.answer == null
                                          ? 0
                                          : state.answer.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30, right: 30),
                                          child: InkWell(
                                            onTap: () {
                                              answer = (state.answer[index]
                                                  ["answer"]);

                                              print(answer);
                                            },
                                            child: Card(
                                              elevation: 3,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: ListTile(
                                                  title: Container(
                                                    child: Column(
                                                      children: [],
                                                    ),
                                                  ),
                                                  subtitle: Container(
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .stretch,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                              ),
                                                              Text('Answer: '),
                                                              Text(
                                                                // "${state.post[index]["body"]}",
                                                                "${state.answer[index]["answer"]}",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 1,
                                                                softWrap: false,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }
                                return Text('');
                              },
                            ),
                            SizedBox(height: 20),
                            Divider(
                              height: 1,
                              thickness: 0.5,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 20),
                            Column(
                              children: [
                                TextFormField(
                                  controller: bodyCont,
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please provide something';
                                    }
                                    return null;
                                  },
                                  maxLines: 5,
                                  onChanged: (value) {
                                    body = value;
                                    if (value.isEmpty) {
                                      return 'Please fill up';
                                    }
                                  },
                                  decoration: InputDecoration(
                                    helperText: 'Include your answer here',
                                    prefixIcon: Icon(
                                      Icons.wysiwyg_outlined,
                                    ),
                                    labelText: 'Answer',
                                    hintText: 'Place your answer here...',
                                    border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                InkWell(
                                  onTap: () {
                                    BlocProvider.of<PostanswerBloc>(context)
                                        .add(PostAnswer(
                                            body: body,
                                            postId: postId,
                                            context: context));

                                    disposed();
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
                                              color: Colors.white,
                                              fontSize: 22),
                                        ),
                                      )),
                                ),

                                //
                                SizedBox(height: 20),
                                InkWell(
                                  onTap: () {
                                    BlocProvider.of<PostanswerBloc>(context)
                                        .add(PostAnswer(
                                            body: body,
                                            postId: postId,
                                            context: context));

                                    disposed();
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
                                          'Get answer',
                                          textAlign: TextAlign.center,
                                          style: kTextButton.copyWith(
                                              color: Colors.white,
                                              fontSize: 22),
                                        ),
                                      )),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return Text('');
              },
            ),
            BlocBuilder<PostanswerBloc, PostanswerState>(
              builder: (context, state) {
                if (state is PostanswerLoading) {
                  return SpinKitFadingCircle(
                    color: Colors.grey,
                    size: 50.0,
                  );
                } else if (state is PostanswerFetch) {
                  Text('Answer Uploaded');
                }
                return Text('');
              },
            )
          ],
        ),
      ),
    );
  }
}
