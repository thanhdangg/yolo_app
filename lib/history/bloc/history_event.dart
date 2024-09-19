part of 'history_bloc.dart';

abstract class HistoryEvent {}


class LoadInitialPhotos extends HistoryEvent {}

class LoadMorePhotos extends HistoryEvent {}