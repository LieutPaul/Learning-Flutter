import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/main.dart';

import '../components/button.dart';
import '../components/text_field.dart';

class RegisterPage extends StatefulWidget {
  final Function()? toggleToLogin;
  const RegisterPage({super.key, required this.toggleToLogin});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final signupformKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final password1Controller = TextEditingController();
  final password2Controller = TextEditingController();
  Future signUp() async {
    if (!signupformKey.currentState!.validate()) {
      return;
    }

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: password1Controller.text.trim());
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message!),
      ));
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  void dispose() {
    emailController.dispose();
    password1Controller.dispose();
    password2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: signupformKey,
              child: ListView(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 100),
                      const Icon(Icons.lock, size: 80),
                      const SizedBox(height: 40),
                      const Text("Welcome to the App! Register here."),
                      const SizedBox(height: 40),
                      CustomTextField(
                          purpose: "email",
                          controller: emailController,
                          hintText: "Enter Email",
                          obscureText: false),
                      const SizedBox(height: 15),
                      CustomTextField(
                          purpose: "password",
                          controller: password1Controller,
                          hintText: "Enter Password",
                          obscureText: true),
                      const SizedBox(height: 15),
                      CustomTextField(
                          purpose: "confirm",
                          onChange: (val) {
                            setState(() {});
                          },
                          // This is to rebuild the widget so that the correct value of password1 is obtained
                          firstPassword: password1Controller.text,
                          controller: password2Controller,
                          hintText: "Confirm Password",
                          obscureText: true),
                      const SizedBox(height: 30),
                      CustomButton(onTap: signUp, text: "Sign Up"),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
                          GestureDetector(
                            onTap: widget.toggleToLogin,
                            child: const Text(
                              "Login Now",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.blue),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}
