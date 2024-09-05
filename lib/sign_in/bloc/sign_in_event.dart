abstract class SignInEvent {}

class SignInSubmitted extends SignInEvent {
  final String email;
  final String password;
  SignInSubmitted(this.email, this.password);
}
