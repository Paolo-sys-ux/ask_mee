import 'package:ask_mee/constants/styles.dart';
import 'package:ask_mee/screens/bloc/display_post/display_post_bloc.dart';
import 'package:ask_mee/screens/view_post_screen/view_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var uid, author, body, title;
  String search;
  TextEditingController searchCont = TextEditingController();
  final _sendKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DisplayPostBloc>(context).add(DisplayData());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          'Search',
          style: kTextButton.copyWith(color: Color(0xFF514A43)),
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ListTile(
              // trailing: IconButton(
              //     key: send,
              //     tooltip: 'Send',
              //     icon: Icon(
              //       Icons.,
              //       color: Colors.black,
              //       size: 30,
              //     ),
              //     onPressed: () {
              //       if (_sendKey.currentState.validate()) {
              //         firestore.collection('messages').add({'text': text});
              //         dispose();
              //         // getMessages();
              //       }
              //     }),
              title: Form(
                key: _sendKey,
                child: TextFormField(
                  controller: searchCont,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Type anything you want to search';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    search = value;
                  },
                  decoration: InputDecoration(
                    focusColor: Colors.black,
                    fillColor: Colors.black,
                    hoverColor: Colors.black,
                    prefixIcon: Icon(Icons.search_sharp),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    labelText: 'Search',
                    hintText: 'How to make lumpia?',
                  ),
                ),
              ),
            ),
          ),
          BlocBuilder<DisplayPostBloc, DisplayPostState>(
            builder: (context, state) {
              if (state is DisplayPostLoading) {
                return Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SpinKitFadingCircle(
                          color: Colors.grey,
                          size: 50.0,
                        ),
                        Text('${state.loadingMessage}'),
                      ],
                    ));
              } else if (state is DisplayPostFetch) {
                return Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.post == null ? 0 : state.post.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: InkWell(
                          onTap: () {
                            uid = (state.post[index].id);
                            author = (state.post[index]["author"]);
                            body = (state.post[index]["body"]);
                            title = (state.post[index]["title"]);
                            print(uid);
                            print(author);
                            print(body);
                            print(title);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewPostScreen(
                                  author: author,
                                  body: body,
                                  title: title,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListTile(
                                title: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text('Topic: '),
                                          Text(
                                            "${state.post[index]["title"]}",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                subtitle: Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text('Sender: '),
                                          Text(
                                            "${state.post[index]["author"]}",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Divider(
                                                height: 1,
                                                thickness: 0.5,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text('Question: '),
                                            Text(
                                              // "${state.post[index]["body"]}",
                                              "${state.post[index]["body"]}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              softWrap: false,
                                              style: TextStyle(
                                                  color: Colors.black),
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
        ],
      ),
    );
  }
}
