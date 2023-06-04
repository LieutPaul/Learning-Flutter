import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sample_crud/main.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback handleSignUpClick;
  const LoginWidget({super.key, required this.handleSignUpClick});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
        password: passwordController.text.trim(),
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
        body: ListView(children: [
      Container(
          margin: const EdgeInsets.only(top: 50),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const Center(
                  child: Text(
                "Provide Login Credentials",
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
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                icon: const Icon(
                  Icons.lock_open,
                  size: 22,
                  color: Colors.white,
                ),
                label: const Text(
                  "Sign In",
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
                    text: "No Account? ",
                    children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.handleSignUpClick,
                          text: "Sign Up",
                          style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color.fromARGB(255, 0, 100, 3)))
                    ]),
              )
            ],
          ))
    ]));
  }
}
