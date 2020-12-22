part of 'upload_image_bloc.dart';

@immutable
abstract class UploadImageEvent {}

class UploadImage extends UploadImageEvent {
  File image;
  GlobalKey key = GlobalKey<ScaffoldState>();
  BuildContext context;

  UploadImage({this.image, this.key, this.context});

  get _scaffoldKey => key;
}

class ViewImage extends UploadImageEvent {
  ViewImage();
}
