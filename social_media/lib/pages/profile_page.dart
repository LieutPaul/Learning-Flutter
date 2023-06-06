import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/components/text_box.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
            backgroundColor: Colors.grey[900],
            title: const Text("Profile Page")),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(currentUser!.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data!.data() as Map<String, dynamic>;
                // userData is like a collection of tuples as stored in Firebase [key,value]
                return ListView(
                  children: [
                    const SizedBox(height: 10),
                    const Icon(
                      Icons.person,
                      size: 100,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      currentUser!.email.toString(),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Text(
                        "My Details",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    CustomTextBox(
                        text: userData['username'],
                        sectionName: "username",
                        onPressed: () => editField('username')),
                    const SizedBox(height: 10),
                    CustomTextBox(
                        text: userData['bio'],
                        sectionName: "bio",
                        onPressed: () => editField('bio')),
                    const SizedBox(height: 10),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("Error ${snapshot.error}");
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }

  Future<void> editField(String s) async {
    String newValue = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.grey[900],
              title:
                  Text("Edit $s", style: const TextStyle(color: Colors.white)),
              content: TextField(
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Enter new $s",
                    hintStyle: const TextStyle(color: Colors.grey)),
                onChanged: (value) {
                  newValue = value;
                },
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(newValue);
                    },
                    child: const Text(
                      "Confirm",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ));
    if (newValue.trim().isNotEmpty) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(currentUser!.email)
          .update({s: newValue.trim()});
    }
  }
}
