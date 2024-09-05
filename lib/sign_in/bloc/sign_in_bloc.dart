import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yolo_app/sign_in/bloc/sign_in_event.dart';
import 'package:yolo_app/sign_in/bloc/sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial());

  @override
  Stream<SignInState> mapEventToState(SignInEvent event) async* {
    if (event is SignInSubmitted) {
      yield SignInLoading();
      try {
        // Implement sign-in logic here, e.g., using Firebase Auth
        yield SignInSuccess();
      } catch (e) {
        yield SignInFailure(e.toString());
      }
    }
  }
}
