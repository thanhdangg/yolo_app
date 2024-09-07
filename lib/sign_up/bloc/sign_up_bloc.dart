import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yolo_app/sign_up/bloc/sign_up_event.dart';
import 'package:yolo_app/sign_up/bloc/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final FirebaseAuth _firebaseAuth;

  SignUpBloc({required BuildContext context})
      : _firebaseAuth = FirebaseAuth.instance,
        super(SignUpInitial()) {
    on<SignUpSubmitted>(_onSignUpSubmitted);
  }

  void _onSignUpSubmitted(SignUpSubmitted event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }
}
