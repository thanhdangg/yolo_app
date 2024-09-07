import 'dart:io';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {}

class HomeFailure extends HomeState {
  final String error;
  HomeFailure(this.error);
}
class ImageChosen extends HomeState {
  final File image;

  ImageChosen(this.image);
}
class UploadingImage extends HomeState {}

class ImageUploaded extends HomeState {
  final String imageUrl;
  ImageUploaded(this.imageUrl);

}
class ImageProgressed extends HomeState {
  final String imageUrl;
  ImageProgressed(this.imageUrl);
}