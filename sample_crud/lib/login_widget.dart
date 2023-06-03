import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

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

    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text("Login Page",
                style: TextStyle(color: Colors.white))),
        body: Container(
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
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
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
                )
              ],
            )));
  }
}
