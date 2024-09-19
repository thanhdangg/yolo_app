import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yolo_app/history/bloc/history_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

@RoutePage()
class HistoryPage extends StatelessWidget {
  final List<String>? imageUrls;

  const HistoryPage({super.key, this.imageUrls});

   @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryBloc(context)..add(LoadInitialPhotos()),
      child: Scaffold(
        appBar: AppBar(title: const Text('History')),
        body: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            debugPrint("=====state: ${state.status}");
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return Center(child: Text('Error: ${state.error}'));
            }
            final pageController = PageController();
            return NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  if (scrollNotification.metrics.pixels >=
                      scrollNotification.metrics.maxScrollExtent * 0.8) {
                    context.read<HistoryBloc>().add(LoadMorePhotos());
                  }
                  return false;
                },
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: state.imageUrls.length,
                        onPageChanged: (index) {
                          if (index >= state.imageUrls.length - 2) {
                            context.read<HistoryBloc>().add(LoadMorePhotos());
                          }
                        },
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: Image.file(
                                File(state.imageUrls[index]),
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
                  ],
                ),
              );
          },
        ),
      ),
    );
  }
}