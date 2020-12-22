import 'package:ask_mee/constants/styles.dart';
import 'package:flutter/material.dart';

class ViewPostScreen extends StatefulWidget {
  String title, author, body;
  ViewPostScreen({this.title, this.author, this.body});

  @override
  _ViewPostScreenState createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends State<ViewPostScreen> {
  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '${widget.title}',
                  style:
                      kTextButton.copyWith(color: Colors.black, fontSize: 28),
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
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
