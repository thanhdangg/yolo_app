import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yolo_app/utils/enums.dart';

part 'history_gallery_state.dart';
part 'history_gallery_event.dart';

class HistoryGalleryBloc
    extends Bloc<HistoryGalleryEvent, HistoryGalleryState> {
  final BuildContext context;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  List<String> _allPhotoUrls = [];

  HistoryGalleryBloc({required this.context})
      : super(HistoryGalleryState.initial()) {
    on<LoadInitialPhotos>(_onLoadInitialPhotos);
    on<SwipeToNextPhoto>(_onSwipeToNextPhoto);
  }
  Future<void> _onLoadInitialPhotos(
      LoadInitialPhotos event, Emitter<HistoryGalleryState> emit) async {
    emit(state.copyWith(status: BlocStateStatus.loading, currentIndex: 0));
    try {
      _allPhotoUrls = await _fetchAllPhotoUrls();
      debugPrint('===All photo URLs: $_allPhotoUrls');
      final List<String> initialPhotoUrls = await _downloadPhotos(0, 2);
      emit(
        state.copyWith(
          status: BlocStateStatus.imagesLoaded,
          photoUrls: initialPhotoUrls,
        ),
      );
    } catch (e) {
      emit(
          state.copyWith(status: BlocStateStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onSwipeToNextPhoto(
      SwipeToNextPhoto event, Emitter<HistoryGalleryState> emit) async {
    final currentIndex = event.currentIndex;
    final nextIndex = currentIndex + 1;

    if (nextIndex < _allPhotoUrls.length) {
      try {
        final List<String> updatedPhotoUrls = List.from(state.photoUrls!);

        if (nextIndex + 1 < _allPhotoUrls.length) {
          final nextPhotoUrl = await _downloadPhoto(nextIndex + 1);
          updatedPhotoUrls.add(nextPhotoUrl);
        }

        if (updatedPhotoUrls.length > 3) {
          final photoToDelete = updatedPhotoUrls.removeAt(0);
          await _deletePhoto(photoToDelete);
        }

        emit(state.copyWith(
          status: BlocStateStatus.imagesLoaded,
          photoUrls: updatedPhotoUrls,
          currentIndex: nextIndex,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: BlocStateStatus.failure,
          error: e.toString(),
        ));
      }
    }
  }

  Future<List<String>> _fetchAllPhotoUrls() async {
    final ListResult result = await _storage.ref('output/test_load').listAll();
    final List<String> photoUrls = await Future.wait(
        result.items.map((Reference ref) => ref.getDownloadURL()).toList(),
      );
    return photoUrls;
  }

  Future<List<String>> _downloadPhotos(int startIndex, int endIndex) async {
    final List<String> photoUrls = [];
    for (int i = startIndex; i <= endIndex; i++) {
      final photoUrl = await _downloadPhoto(i);
      photoUrls.add(photoUrl);
    }
    return photoUrls;
  }

  Future<String> _downloadPhoto(int index) async {
    final ref = _storage.refFromURL(_allPhotoUrls[index]);
    final downloadUrl = await ref.getDownloadURL();
    await GallerySaver.saveImage(downloadUrl);
    return downloadUrl;
  }

  Future<void> _deletePhoto(String photoUrl) async {
    try {
      final directory = await getExternalStorageDirectory();
      final filePath = '${directory!.path}/${photoUrl.split('/').last}';

      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        debugPrint('===Photo deleted from gallery: $filePath');
      } else {
        debugPrint('===Photo not found in gallery: $filePath');
      }
    } catch (e) {
      debugPrint('===Failed to delete photo: $photoUrl. Error: $e');
    }
  }
}
