import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yolo_app/sign_in/bloc/sign_in_event.dart';
import 'package:yolo_app/sign_in/bloc/sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final BuildContext context;
  final FirebaseAuth _firebaseAuth;
  SignInBloc({required this.context})
      : _firebaseAuth = FirebaseAuth.instance,
        super(SignInInitial()) {
    on<SignInSubmitted>(_onSignInSubmitted);
  }

  void _onSignInSubmitted(
      SignInSubmitted event, Emitter<SignInState> emit) async {
    emit(SignInLoading());
    debugPrint("==================_onSignInSubmitted");
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      final emailWithoutDomain = event.email.split('@').first;
      debugPrint(
          '======================emailWithoutDomain: $emailWithoutDomain');
      emit(SignInSuccess());
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setString('userEmail', emailWithoutDomain);
    } on FirebaseAuthException catch (e) {
      debugPrint('======================error: ${e.message}');
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is not valid.';
          break;
        case 'user-disabled':
          errorMessage =
              'The user corresponding to the given email has been disabled.';
          break;
        case 'user-not-found':
          errorMessage = 'There is no user corresponding to the given email.';
          break;
        case 'wrong-password':
          errorMessage = 'The password is invalid for the given email.';
          break;
        default:
          errorMessage = 'An unknown error occurred.';
      }
      emit(SignInFailure(errorMessage));
    } catch (e) {
      debugPrint('======================error: $e');
      emit(SignInFailure(e.toString()));
    }
  }
}
