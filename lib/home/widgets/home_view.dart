import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yolo_app/history/history_page.dart';
import 'package:yolo_app/history_gallert/history_gallery_page.dart';
import 'package:yolo_app/home/bloc/home_bloc.dart';
import 'package:yolo_app/utils/enums.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(context: context),
      child: Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state.status == BlocStateStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error ?? 'Error occurred')),
              );
            } else if (state.status == BlocStateStatus.imageUploaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Image uploaded: ${state.imageUrl}')),
              );
            } else if (state.status == BlocStateStatus.imageProgressed) {
              debugPrint(
                  '==================imageUrl ImageProgressed on home view: ${state.imageUrl}');

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Image processed: ${state.imageUrl}')),
              );
            }
          },
          builder: (context, state) {
            debugPrint("==========state: ${state.status}");
            if (state.status == BlocStateStatus.initial) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<HomeBloc>()
                            .add(ChooseImage(ImageSource.camera));
                      },
                      child: const Text('Choose from Camera'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<HomeBloc>()
                            .add(ChooseImage(ImageSource.gallery));
                      },
                      child: const Text('Choose from Gallery'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HistoryPage(),
                          ),
                        );
                      },
                      child: const Text('View History with link'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistoryGalleryPage(),
                          ),
                        );
                      },
                      child: const Text('View History from gallery'),
                    ),
                  ],
                ),
              );
            } else if (state.status == BlocStateStatus.imageChosen) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.file(state.image!),
                    ElevatedButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(UploadImage(state.image!));
                      },
                      child: const Text('Upload Image'),
                    ),
                  ],
                ),
              );
            } else if (state.status == BlocStateStatus.uploadingImage) {
              return const Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text("Uploading Image..."),
                ],
              ));
            } else if (state.status == BlocStateStatus.imageUploaded) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(state.imageUrl!),
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    const Text('Server Processing...'),
                  ],
                ),
              );
            } else if (state.status == BlocStateStatus.imageProgressed) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      state.imageUrl!,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Try again',
                      ),
                    ),
                  ],
                ),
              );
            } else if (state.status == BlocStateStatus.loading) {
              return const Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text("Loading..."),
                ],
              ));
            } else if (state.status == BlocStateStatus.success) {
              return const Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Success"),
                ],
              ));
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<HomeBloc>()
                            .add(ChooseImage(ImageSource.camera));
                      },
                      child: const Text('Choose from Camera'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<HomeBloc>()
                            .add(ChooseImage(ImageSource.gallery));
                      },
                      child: const Text('Choose from Gallery'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}


// /Users/dang/development/flutter/flutter