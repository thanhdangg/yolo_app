import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yolo_app/history_gallert/bloc/history_gallery_bloc.dart';
import 'package:yolo_app/utils/enums.dart';

@RoutePage()
class HistoryGalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryGalleryBloc(context: context)..add(LoadInitialPhotos()),
      child: Scaffold(
        appBar: AppBar(title: const Text('History Gallery')),
        body: BlocBuilder<HistoryGalleryBloc, HistoryGalleryState>(
          builder: (context, state) {
            if (state.status == BlocStateStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == BlocStateStatus.failure) {
              return Center(child: Text('Error: ${state.error}'));
            }

            if (state.status == BlocStateStatus.imagesLoaded) {
              final pageController = PageController(initialPage: state.currentIndex!);

              return Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: state.photoUrls!.length,
                      onPageChanged: (index) {
                        context.read<HistoryGalleryBloc>().add(SwipeToNextPhoto(index));
                      },
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.network(
                              state.photoUrls![index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  color: Colors.grey,
                                  child: const Icon(
                                    Icons.error,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: state.photoUrls!.length,
                    effect: WormEffect(),
                  ),
                ],
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}