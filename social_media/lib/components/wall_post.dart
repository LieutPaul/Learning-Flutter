import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/components/comment.dart';
import 'package:social_media/components/comment_button.dart';
import 'package:social_media/components/like_button.dart';

class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String postId;
  final List<String> likes; // All emails of users that liked it.
  final Timestamp? time;
  final List<dynamic> comments;
  const WallPost(
      {super.key,
      required this.message,
      required this.user,
      this.time,
      required this.postId,
      required this.likes,
      required this.comments});

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  final currentUser = FirebaseAuth.instance.currentUser;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser!.email);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
    // Removing or adding the email of current user to list of emails that have liked this post
    DocumentReference postRef =
        FirebaseFirestore.instance.collection("User Posts").doc(widget.postId);
    if (isLiked) {
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser!.email])
      });
    } else {
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser!.email])
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(3)),
        margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
        padding: const EdgeInsets.all(25),
        child: Row(children: [
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.message),
                postText(),
                likeAndCommentIcons(),
                commentsSection()
              ],
            ),
          ),
        ]));
  }

  Row likeAndCommentIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            LikeButton(
              isLiked: isLiked,
              onTap: toggleLike,
            ),
            const SizedBox(height: 5),
            Text(widget.likes.length.toString())
          ],
        ),
        const SizedBox(width: 10),
        Column(
          children: [
            CommentButton(
              postId: widget.postId,
            ),
            const SizedBox(height: 5),
            Text(widget.comments.length.toString())
          ],
        ),
      ],
    );
  }

  Row postText() {
    return Row(
      children: [
        Text(widget.user, style: TextStyle(color: Colors.grey[400])),
        Column(children: [
          Text(" . ", style: TextStyle(fontSize: 20, color: Colors.grey[400])),
          const SizedBox(height: 13),
        ]),
        Text(
            "${widget.time!.toDate().day}/${widget.time!.toDate().month}/${widget.time!.toDate().year}",
            style: TextStyle(color: Colors.grey[400])),
      ],
    );
  }

  Container commentsSection() {
    return Container(
        padding: EdgeInsets.zero,
        height: widget.comments.length >= 2
            ? 150
            : (widget.comments.isNotEmpty ? 100 : 10),
        child: ListView(
          children: widget.comments.map((comment) {
            return Comment(
              text: comment['Comment'],
              user: comment['User'],
              time: comment['TimeStamp'],
            );
          }).toList(),
        ));
  }
}
