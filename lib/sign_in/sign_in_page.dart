import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:yolo_app/sign_in/widgets/sign_in_view.dart';

@RoutePage()
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return SignInView();
  }
  
}