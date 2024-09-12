part of 'home_bloc.dart';

class HomeState {
  final BlocStateStatus status;
  final String? error;
  final File? image;
  final String? imageUrl;
  final List<String>? imageUrls;


  HomeState({
    required this.status,
    this.error,
    this.image,
    this.imageUrl,
    this.imageUrls,

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
  // factory HomeState.imagesLoaded(List<String> imageUrls) => HomeState(
  //       status: BlocStateStatus.imagesLoaded,
  //       imageUrls: imageUrls,
  //     );  

  HomeState copyWith({
    BlocStateStatus? status,
    String? error,
    File? image,
    String? imageUrl,
    // List<String>? imageUrls,
  }) {
    return HomeState(
      status: status ?? this.status,
      error: error ?? this.error,
      image: image ?? this.image,
      imageUrl: imageUrl ?? this.imageUrl,
      // imageUrls: imageUrls ?? this.imageUrls, 
    );
  }
}
