import 'package:flutter/material.dart';

class WallPost extends StatelessWidget {
  final String message;
  final String user;
  final String? time;
  const WallPost(
      {super.key, required this.message, required this.user, this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [Text(message), Text(user)],
        )
      ],
    );
  }
}
