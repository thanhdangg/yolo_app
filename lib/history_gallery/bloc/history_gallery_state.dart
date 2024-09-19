part of 'history_gallery_bloc.dart';

class HistoryGalleryState {
  final BlocStateStatus status;
  final List<String>? photoUrls;
  final int? currentIndex;
  final String? error;

  HistoryGalleryState({
    required this.status,
    this.photoUrls,
    this.currentIndex,
    this.error,
  });

  factory HistoryGalleryState.initial() => HistoryGalleryState(
        status: BlocStateStatus.initial,
        photoUrls: [],
        currentIndex: 0,
        error: null,
      );
      HistoryGalleryState copyWith({
        required BlocStateStatus status,
        List<String>? photoUrls,
        int? currentIndex,
        String? error,
      }) =>
          HistoryGalleryState(
            status: status,
            photoUrls: photoUrls ?? this.photoUrls,
            currentIndex: currentIndex ?? this.currentIndex,
            error: error ?? this.error,
          );
}
