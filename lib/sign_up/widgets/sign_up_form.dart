import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yolo_app/sign_up/bloc/sign_up_bloc.dart';
import 'package:yolo_app/sign_up/bloc/sign_up_event.dart';

// ignore: must_be_immutable
class SignUpForm extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String email = '';
  String password = '';
  String confirmPassword = '';

  SignUpForm({super.key});
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
              onSaved: (value) {
                email = value!;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              onSaved: (value) {
                password = value!;
              },
            ),
            TextFormField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != password) {
                  return 'Passwords do not match';
                }
                return null;
              },
              onSaved: (value) {
                confirmPassword = value!;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<SignUpBloc>().add(SignUpSubmitted(
                      _emailController.text,
                      _passwordController.text,
                      _confirmPasswordController.text,
                    ));
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
