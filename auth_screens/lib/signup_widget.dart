import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sample_crud/main.dart';

class SignUpWidget extends StatefulWidget {
  final VoidCallback handleLogInClick; // To take to login page
  const SignUpWidget({super.key, required this.handleLogInClick});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  // Will help in verifying fields after user submits

  final emailController = TextEditingController();
  final password1Controller = TextEditingController();
  final password2Controller = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    password1Controller.dispose();
    password2Controller.dispose();
    super.dispose();
  }

  Future signUp() async {
    if (!formKey.currentState!.validate()) {
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
      // ignore: avoid_print
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message!),
      )); // To display error messages
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ListView(children: [
          Form(
            key: formKey,
            child: Container(
                margin: const EdgeInsets.only(top: 50),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const Center(
                        child: Text(
                      "Provide Sign-up Credentials",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    )),
                    const SizedBox(height: 30),
                    TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? 'Enter a valid Email'
                                : null),
                    const SizedBox(height: 30),
                    TextFormField(
                      obscureText: true,
                      controller: password1Controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) => value != null && value.length < 6
                          ? "Enter min 6 characters"
                          : null,
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      obscureText: true,
                      controller: password2Controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Confirm Password',
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          value != null && value != password1Controller.text
                              ? "Passwords don't match"
                              : null,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black),
                      icon: const Icon(
                        Icons.lock_open,
                        size: 22,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: signUp,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                      text: TextSpan(
                          style: const TextStyle(color: Colors.black),
                          text: "Already have an Account? ",
                          children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = widget
                                      .handleLogInClick, // To take to login page
                                text: "Log In",
                                style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Color.fromARGB(255, 0, 100, 3)))
                          ]),
                    )
                  ],
                )),
          )
        ]));
  }
}
