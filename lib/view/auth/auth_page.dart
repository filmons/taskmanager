import 'package:flutter/material.dart';
import 'package:taskmanager/view/auth/signup.dart';
import 'package:taskmanager/view/auth/signin.dart';

class AuthPage extends StatefulWidget {
  AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool a = true;
  void to() {
    setState(() {
      a = !a;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (a) {
      return SignInScreen(to);
    } else {
      return SignUpScreen(to);
    }
  }
}