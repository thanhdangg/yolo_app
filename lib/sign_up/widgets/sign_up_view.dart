import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yolo_app/configs/app_router.gr.dart';
import 'package:yolo_app/sign_up/bloc/sign_up_bloc.dart';
import 'package:yolo_app/sign_up/bloc/sign_up_state.dart';
import 'package:yolo_app/sign_up/widgets/sign_up_form.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(context: context),
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign Up')),
        body: BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              context.router.replace(const HomeRoute());
            } else if (state is SignUpFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: BlocBuilder<SignUpBloc, SignUpState>(
            builder: (context, state) {
              if (state is SignUpLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return SignUpForm();
              }
            },
          ),
        ),
      ),
    );
  }
}
