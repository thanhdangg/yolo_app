import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:yolo_app/utils/enums.dart';

part 'history_state.dart';
part 'history_event.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final BuildContext context;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  List<String> _allPhotoUrls = [];
  int _currentBatchIndex = 0;
  static const int _batchSize = 10;

  HistoryBloc(this.context): super(HistoryState.initial()) {
    on<LoadInitialPhotos>(_onLoadInitialPhotos);
    on<LoadMorePhotos>(_onLoadMorePhotos);
  }

  Future<void> _onLoadInitialPhotos(
      LoadInitialPhotos event, Emitter<HistoryState> emit) async {
    emit(state.copyWith(status: BlocStateStatus.loading));
    try {
      _allPhotoUrls = await _fetchAllPhotoUrls();
      final List<String> initialPhotoPaths = await _downloadPhotos(0, _batchSize - 1);
      debugPrint("===initialPhotoPaths $initialPhotoPaths");
      _currentBatchIndex = _batchSize;
      emit(state.copyWith(
        status: BlocStateStatus.imagesLoaded,
        imageUrls: initialPhotoPaths,
      ));
    } catch (e) {
      emit(state.copyWith(status: BlocStateStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onLoadMorePhotos(
      LoadMorePhotos event, Emitter<HistoryState> emit) async {
    if (_currentBatchIndex >= _allPhotoUrls.length) return;

    try {
      final List<String> morePhotoPaths = await _downloadPhotos(
        _currentBatchIndex,
        _currentBatchIndex + _batchSize - 1,
      );
      _currentBatchIndex += _batchSize;
      emit(state.copyWith(
        status: BlocStateStatus.imagesLoaded,
        imageUrls: [...state.imageUrls, ...morePhotoPaths],
      ));
    } catch (e) {
      emit(state.copyWith(status: BlocStateStatus.failure, error: e.toString()));
    }
  }

  Future<List<String>> _fetchAllPhotoUrls() async {
    final List<String> photoUrls = [];
    final ListResult result = await _storage.ref('input').listAll();
    for (var ref in result.items) {
      final downloadUrl = await ref.getDownloadURL();
      photoUrls.add(downloadUrl);
    }
    return photoUrls;
  }

  Future<List<String>> _downloadPhotos(int startIndex, int endIndex) async {
    final List<String> photoPaths = [];
    for (int i = startIndex; i <= endIndex && i < _allPhotoUrls.length; i++) {
      final photoPath = await _downloadPhoto(i);
      photoPaths.add(photoPath);
    }
    debugPrint("===photoPaths $photoPaths");
    return photoPaths;
  }

  Future<String> _downloadPhoto(int index) async {
    final downloadUrl = _allPhotoUrls[index];
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/${downloadUrl.split('/').last}';
    final file = File(filePath);
    if (!await file.exists()) {
      final response = await HttpClient().getUrl(Uri.parse(downloadUrl));
      final bytes = await consolidateHttpClientResponseBytes(await response.close());
      await file.writeAsBytes(bytes);
    }
    return filePath;
  }
}