import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title:
              const Text("Home Page", style: TextStyle(color: Colors.white))),
      body: Container(
        padding: const EdgeInsets.only(top: 30),
        child: Column(children: [
          Center(child: Text(("You are logged in as ${user?.email}"))),
          const SizedBox(
            height: 20,
          ),
          Center(
              child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            icon: const Icon(
              Icons.lock_person,
              size: 22,
              color: Colors.white,
            ),
            label: const Text(
              "Sign Out",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: signOut,
          ))
        ]),
      ),
    );
  }
}
