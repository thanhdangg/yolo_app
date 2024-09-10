import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yolo_app/configs/app_router.gr.dart';
import 'package:yolo_app/sign_in/bloc/sign_in_bloc.dart';
import 'package:yolo_app/sign_in/bloc/sign_in_event.dart';

class SignInForm extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  SignInForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<SignInBloc>().add(SignInSubmitted(
                      _emailController.text,
                      _passwordController.text,
                    ));
              },
              child: const Text('Sign In'),
            ),
            TextButton(
              onPressed: () {
                context.router.push(const SignUpRoute());
              },
              child: const Text('Don’t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
