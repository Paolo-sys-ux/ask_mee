part of 'upload_image_bloc.dart';

@immutable
abstract class UploadImageState {}

class UploadImageInitial extends UploadImageState {}

class UploadImageLoading extends UploadImageState {}

class UploadImageDone extends UploadImageState {}

class UploadImageError extends UploadImageState {}
