import 'package:flutter/material.dart';
import 'package:social_media/pages/login_widget.dart';
import 'package:social_media/pages/register_widget.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLogin = true;
  void toggleDisplay() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLogin
        ? LoginPage(toggleToRegister: toggleDisplay)
        : RegisterPage(toggleToLogin: toggleDisplay);
  }
}
