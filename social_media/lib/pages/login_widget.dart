import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: const SafeArea(
            child: Center(
                child: Column(
          children: [
            SizedBox(height: 100),
            Icon(Icons.lock, size: 80),
            SizedBox(height: 40),
            Text("Welcome to the App!"),
            SizedBox(height: 100),
          ],
        ))));
  }
}
