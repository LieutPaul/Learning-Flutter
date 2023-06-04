import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sample_crud/main.dart';

class SignUpWidget extends StatefulWidget {
  final VoidCallback handleSignUpClick;
  const SignUpWidget({super.key, required this.handleSignUpClick});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
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

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: password1Controller.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      // ignore: avoid_print
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: const EdgeInsets.only(top: 50),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                const Center(
                    child: Text(
                  "Provide Sign-up Credentials",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                )),
                const SizedBox(height: 30),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  obscureText: true,
                  controller: password1Controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
                const SizedBox(height: 30),
                TextField(
                  obscureText: true,
                  controller: password2Controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  icon: const Icon(
                    Icons.lock_open,
                    size: 22,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: signIn,
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
                              ..onTap = widget.handleSignUpClick,
                            text: "Log In",
                            style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color.fromARGB(255, 0, 100, 3)))
                      ]),
                )
              ],
            )));
  }
}
