import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'display_post_event.dart';
part 'display_post_state.dart';

class DisplayPostBloc extends Bloc<DisplayPostEvent, DisplayPostState> {
  DisplayPostBloc() : super(DisplayPostInitial());

  @override
  Stream<DisplayPostState> mapEventToState(
    DisplayPostEvent event,
  ) async* {
    // TODO: implement mapEventToState

    yield DisplayPostLoading(loadingMessage: 'Loading...');
    if (event is DisplayData) {
      try {
        final post = await FirebaseFirestore.instance.collection('post').get();
        post.docs.forEach((element) {
          element.data();
          print(element.data());
          print(element.id);
        });
        yield DisplayPostFetch(post.docs);
      } catch (e) {
        yield DisplayPostError(errorMessage: e.toString());
      }
    }
  }
}
