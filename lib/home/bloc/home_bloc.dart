import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yolo_app/home/bloc/home_event.dart';
import 'package:yolo_app/home/bloc/home_state.dart';
import 'package:path/path.dart' as path;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  // late String email;

  final BuildContext context;
  HomeBloc({required this.context}) : super(HomeInitial()) {
    on<ChooseImage>(_onChooseImage);
    on<UploadImage>(_onUploadImage);
  }
  // Future<void> loadEmail() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   email = prefs.getString('userEmail') ?? 'unknown';
  // }
  Future<void> _onChooseImage(
      ChooseImage event, Emitter<HomeState> emit) async {
    try {
      final pickedFile = await _picker.pickImage(source: event.source);
      if (pickedFile != null) {
        emit(ImageChosen(File(pickedFile.path)));
      } else {
        emit(HomeFailure('No image selected'));
      }
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }

  Future<void> _onUploadImage(
      UploadImage event, Emitter<HomeState> emit) async {
    emit(UploadingImage());
    try {
      final fileName = path.basename(event.image.path);

      final ref = _storage.ref().child('input/$fileName');

      final uploadTask = ref.putFile(event.image);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      emit(ImageUploaded(downloadUrl));

      await _database.reference().child('uploads/dang').set({
        'fileName': fileName,
        'url': downloadUrl,
      });

    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }
}
