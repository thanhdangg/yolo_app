import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yolo_app/utils/enums.dart';

part 'history_state.dart';
part 'history_event.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final BuildContext context;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  HistoryBloc(this.context): super(HistoryState.initial()) {
    on<LoadHistoryImages>(_onLoadHistoryImages);
  }

  Future<void> _onLoadHistoryImages(
    LoadHistoryImages events, Emitter<HistoryState> emit) async{
      emit(state.copyWith(status: BlocStateStatus.loading, isLoading: true));
        try {
      final ListResult result = await _storage
      .ref('output/test_load')
      .listAll();
      final List<String> imageUrls = await Future.wait(
        result.items.map((Reference ref) => ref.getDownloadURL()).toList(),
      );
      debugPrint("=====imageUrls: $imageUrls");

      if (imageUrls.isEmpty) {
        emit(state.copyWith(status: BlocStateStatus.failure, isLoading: false, error: "No images found"));
        return;
      }
      emit(state.copyWith(status: BlocStateStatus.imagesLoaded, imageUrls: imageUrls, isLoading: false));
    } catch (e) {
      emit(state.copyWith(status: BlocStateStatus.failure, error: e.toString()));
    }
    }
  
}