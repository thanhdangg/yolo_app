import 'dart:async';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:yolo_app/utils/enums.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  StreamSubscription<DatabaseEvent>? subscription;

  // late String email;

  final BuildContext context;
  HomeBloc({required this.context}) : super(HomeState.initial()) {
    on<ChooseImage>(_onChooseImage);
    on<UploadImage>(_onUploadImage);
    on<ResetState>(_onResetState);
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
        emit(HomeState.imageChosen(File(pickedFile.path)));
      } else {
        emit(HomeState.failure('No image selected'));
      }
    } catch (e) {
      emit(HomeState.failure(e.toString()));
    }
  }

  Future<void> _onUploadImage(
      UploadImage event, Emitter<HomeState> emit) async {
    emit(HomeState.imageUploading());
    try {
      final fileName = path.basename(event.image.path);

      final ref = _storage.ref().child('input/$fileName');

      final uploadTask = ref.putFile(event.image);
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();
      emit(HomeState.imageUploaded(downloadUrl));

      await _database.reference().child('input/dang').set({
        'fileName': fileName,
        'url': downloadUrl,
      });

      // Read data once using get()
      final outputRef = _database.ref('output');
      try {
        final dataSnapshot = await outputRef.get();
        final imageUrl =
            dataSnapshot.child('processed_image_url').value as String?;
        debugPrint('==================imageUrl: $imageUrl');
        String? newUrl = imageUrl;
        int i = 0;
        do {
          i+=1;
          debugPrint('================i: $i');
          final dataSnapshotNew = await outputRef.get();
          newUrl = dataSnapshotNew.child('processed_image_url').value as String?;
          debugPrint('================newUrl: $newUrl');
          debugPrint('================imageUrl: $imageUrl');
        } while (newUrl == imageUrl);

        if (newUrl != null) {
          emit(
            state.copyWith(
              status: BlocStateStatus.imageProgressed,
              imageUrl: newUrl,
            ),
          );
        } else {
          debugPrint('================ImageProgressed imageUrl null');
          emit(state.copyWith(
            status: BlocStateStatus.failure,
            error: 'Processed image URL is null',
          ));
        }
      } catch (e) {
        debugPrint('==================on Error: $e');
        emit(
          state.copyWith(
            status: BlocStateStatus.failure,
            error: e.toString(),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: BlocStateStatus.failure,
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> _onResetState(
      ResetState event, Emitter<HomeState> emit) async {
    emit(HomeState.initial());
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
