part of 'home_bloc.dart';

class HomeState {
  final BlocStateStatus status;
  final String? error;
  final File? image;
  final String? imageUrl;

  HomeState({
    required this.status,
    this.error,
    this.image,
    this.imageUrl,
  });

  factory HomeState.initial() => HomeState(
        status: BlocStateStatus.initial,
      );
  factory HomeState.loading() => HomeState(
        status: BlocStateStatus.loading,
      );
  factory HomeState.success() => HomeState(
        status: BlocStateStatus.success,
      );
  factory HomeState.failure(String error) => HomeState(
        status: BlocStateStatus.failure,
        error: error,
      );
  factory HomeState.imageChosen(File image) => HomeState(
        status: BlocStateStatus.imageChosen,
        image: image,
        imageUrl: null,
      );
  factory HomeState.imageUploading() => HomeState(
        status: BlocStateStatus.loading,
      );
  factory HomeState.imageUploaded(String imageUrl) => HomeState(
        status: BlocStateStatus.imageUploaded,
        imageUrl: imageUrl,
      );
  factory HomeState.imageProgressed(String imageUrl) => HomeState(
        status: BlocStateStatus.imageProgressed,
        imageUrl: imageUrl,
      );


  HomeState copyWith({
    BlocStateStatus? status,
    String? error,
    File? image,
    String? imageUrl,
  }) {
    return HomeState(
      status: status ?? this.status,
      error: error ?? this.error,
      image: image ?? this.image,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
// class HomeInitial extends HomeState {}

// class HomeLoading extends HomeState {}

// class HomeSuccess extends HomeState {}

// class HomeFailure extends HomeState {
//   final String error;
//   HomeFailure(this.error);
// }
// class ImageChosen extends HomeState {
//   final File image;

//   ImageChosen(this.image);
// }
// class UploadingImage extends HomeState {}

// class ImageUploaded extends HomeState {
//   final String imageUrl;
//   ImageUploaded(this.imageUrl);

// }
// class ImageProgressed extends HomeState {
//   final String imageUrl;
//   ImageProgressed(this.imageUrl);
// }