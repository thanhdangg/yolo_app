
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yolo_app/sign_in/bloc/sign_in_bloc.dart';
import 'package:yolo_app/sign_in/bloc/sign_in_event.dart';
import 'package:yolo_app/sign_in/bloc/sign_in_state.dart';

class SignInView extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: BlocProvider(
        create: (_) => SignInBloc(),
        child: BlocListener<SignInBloc, SignInState>(
          listener: (context, state) {
            if (state is SignInSuccess) {
              context.router.replace(HomeRoute());
            } else if (state is SignInFailure) {
              ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<SignInBloc>().add(SignInSubmitted(
                      _emailController.text,
                      _passwordController.text,
                    ));
                  },
                  child: Text('Sign In'),
                ),
                TextButton(
                  onPressed: () {
                    context.router.push(SignUpRoute());
                  },
                  child: Text('Don’t have an account? Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}