import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yolo_app/configs/app_router.gr.dart';
import 'package:yolo_app/sign_in/bloc/sign_in_bloc.dart';
import 'package:yolo_app/sign_in/bloc/sign_in_event.dart';
import 'package:yolo_app/sign_in/bloc/sign_in_state.dart';
import 'package:yolo_app/sign_in/widgets/sign_in_form.dart';

class SignInView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(context: context),
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign In')),
        body: BlocListener<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state is SignInSuccess) {
              context.router.replace(const HomeRoute());
            } else if (state is SignInFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              if (state is SignInLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return SignInForm();
              }
            },
          ),
        ),
      ),
    );
  }
}
