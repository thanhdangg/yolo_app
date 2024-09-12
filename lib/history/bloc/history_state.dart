part of 'history_bloc.dart';

class HistoryState {
  final BlocStateStatus status;
  final List<String> imageUrls;
  final bool isLoading;
  final String? error;

  HistoryState({
    required this.status,
    required this.imageUrls,
    required this.isLoading,
    this.error,
  });
  factory HistoryState.initial() => HistoryState(
        status: BlocStateStatus.initial,
        imageUrls: [],
        isLoading: false,
        error: null,
      );
  HistoryState copyWith({
    required BlocStateStatus status,
    List<String>? imageUrls,
    bool? isLoading,
    String? error,
  }) =>
      HistoryState(
        status: status,
        imageUrls: imageUrls ?? this.imageUrls,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
      );
}
