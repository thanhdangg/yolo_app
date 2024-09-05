abstract class SignUpEvent {}

class SignUpSubmitted extends SignUpEvent {
  final String email;
  final String password;
  final String confirmPassword;
  SignUpSubmitted(this.email, this.password, this.confirmPassword);
}
