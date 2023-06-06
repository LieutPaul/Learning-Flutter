import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String text;
  final String user;
  final Timestamp time;
  const Comment(
      {super.key, required this.text, required this.user, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(color: Colors.grey[300]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          text,
        ),
        Row(
          children: [
            Text(user, style: TextStyle(color: Colors.grey[500])),
            Column(children: [
              Text(" . ",
                  style: TextStyle(fontSize: 20, color: Colors.grey[500])),
              const SizedBox(height: 13),
            ]),
            Text(
                "${time.toDate().day}/${time.toDate().month}/${time.toDate().year}",
                style: TextStyle(color: Colors.grey[500])),
          ],
        ),
      ]),
    );
  }
}
