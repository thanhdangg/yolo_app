import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class HomeEvent {}

class ChooseImage extends HomeEvent {
  final ImageSource source;
  ChooseImage(this.source);
}
class UploadImage extends HomeEvent {
  final File image;
  UploadImage(this.image);  
}



