part of 'history_gallery_bloc.dart';

abstract class HistoryGalleryEvent  {}

class LoadInitialPhotos extends HistoryGalleryEvent {}

class SwipeToNextPhoto extends HistoryGalleryEvent {
  final int currentIndex;

  SwipeToNextPhoto(this.currentIndex);
}