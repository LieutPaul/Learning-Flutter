import 'package:flutter/material.dart';
import 'package:sample_crud/login_widget.dart';
import 'package:sample_crud/signup_widget.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  void toggle() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    return isLogin == true
        ? LoginWidget(handleSignUpClick: toggle)
        : SignUpWidget(handleSignUpClick: toggle);
  }
}
