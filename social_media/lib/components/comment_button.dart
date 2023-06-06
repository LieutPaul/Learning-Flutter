import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CommentButton extends StatefulWidget {
  final String postId;
  const CommentButton({super.key, required this.postId});

  @override
  State<CommentButton> createState() => _CommentButtonState();
}

class _CommentButtonState extends State<CommentButton> {
  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => newComment(),
        child: const Icon(Icons.comment, color: Colors.grey));
  }

  Future<void> newComment() async {
    String newComment = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.grey[900],
              title: const Text("Add New Comment",
                  style: TextStyle(color: Colors.white)),
              content: TextField(
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                    hintText: "Comment",
                    hintStyle: TextStyle(color: Colors.grey)),
                onChanged: (value) {
                  newComment = value;
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
                      Navigator.of(context).pop(newComment);
                    },
                    child: const Text(
                      "Confirm",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ));
    if (newComment.trim().isNotEmpty) {
      DocumentReference postRef = FirebaseFirestore.instance
          .collection("User Posts")
          .doc(widget.postId);

      postRef.update({
        'Comments': FieldValue.arrayUnion([
          {
            'User': currentUser!.email,
            'Comment': newComment.trim(),
            'TimeStamp': Timestamp.now()
          }
        ])
      });
    }
  }
}
