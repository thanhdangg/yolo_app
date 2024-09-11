part of 'home_bloc.dart';

abstract class HomeEvent {}

class ChooseImage extends HomeEvent {
  final ImageSource source;
  ChooseImage(this.source);
}
class UploadImage extends HomeEvent {
  final File image;
  UploadImage(this.image);  
}



