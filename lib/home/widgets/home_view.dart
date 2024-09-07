import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yolo_app/home/bloc/home_bloc.dart';
import 'package:yolo_app/home/bloc/home_event.dart';
import 'package:yolo_app/home/bloc/home_state.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(context: context),
      child: Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            } else if (state is ImageUploaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Image uploaded: ${state.imageUrl}')),
              );
            }
          },
          builder: (context, state) {
            if (state is HomeInitial) {
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
            } else if (state is ImageChosen) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.file(state.image),
                    ElevatedButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(UploadImage(state.image));
                      },
                      child: const Text('Upload Image'),
                    ),
                  ],
                ),
              );
            } else if (state is UploadingImage) {
              return const Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text("Uploading Image..."),
                ],
              ));
            } else if (state is ImageUploaded) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(state.imageUrl),
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    const Text('Server Processing...'),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Welcome Home!'));
            }
          },
        ),
      ),
    );
  }
}
