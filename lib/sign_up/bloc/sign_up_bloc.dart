import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yolo_app/sign_up/bloc/sign_up_event.dart';
import 'package:yolo_app/sign_up/bloc/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpSubmitted) {
      yield SignUpLoading();
      try {
        // Implement sign-up logic here, e.g., using Firebase Auth
        yield SignUpSuccess();
      } catch (e) {
        yield SignUpFailure(e.toString());
      }
    }
  }
  
}