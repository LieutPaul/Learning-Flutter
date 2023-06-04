import 'package:flutter/material.dart';
import 'package:social_media/components/button.dart';
import 'package:social_media/components/text_field.dart';

class LoginPage extends StatefulWidget {
  final Function()? toggleToRegister;
  const LoginPage({super.key, this.toggleToRegister});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginformKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
              key: loginformKey,
              child: ListView(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 100),
                      const Icon(Icons.lock, size: 80),
                      const SizedBox(height: 40),
                      const Text("Welcome to the App! Login Here."),
                      const SizedBox(height: 40),
                      CustomTextField(
                          purpose: "email",
                          controller: emailController,
                          hintText: "Enter Email",
                          obscureText: false),
                      const SizedBox(height: 15),
                      CustomTextField(
                          purpose: "password",
                          controller: passwordController,
                          hintText: "Enter Password",
                          obscureText: true),
                      const SizedBox(height: 30),
                      CustomButton(onTap: () {}, text: "Sign In"),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Not a Member? "),
                          GestureDetector(
                            onTap: widget.toggleToRegister,
                            child: const Text(
                              "Register Now",
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
