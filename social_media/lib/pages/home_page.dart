import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media/components/drawer.dart';
import 'package:social_media/components/text_field.dart';
import 'package:social_media/components/wall_post.dart';
import 'package:social_media/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void postMessage() {
    if (textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("User Posts").add({
        'UserEmail': currentUser.email,
        'Message': textController.text,
        'TimeStamp': Timestamp.now(),
        'Likes': [],
        'Comments': []
      });
    }
    textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onSignOut: signOut,
      ),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("The Wall"),
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
          child: Column(children: [
        displayPosts(),
        addPost(),
        Text("Logged in as: ${currentUser.email!}"),
        const SizedBox(height: 20),
      ])),
    );
  }

  Padding addPost() {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Row(
        children: [
          Expanded(
              child: CustomTextField(
            controller: textController,
            hintText: 'Write something on the Wall',
            obscureText: false,
          )),
          IconButton(onPressed: postMessage, icon: const Icon(Icons.post_add))
        ],
      ),
    );
  }

  Expanded displayPosts() {
    return Expanded(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("User Posts")
              .orderBy("TimeStamp", descending: false)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final post = snapshot.data!.docs[index];
                    final message = post.data().containsKey('Message')
                        ? post['Message']
                        : '';
                    final user = post.data().containsKey('UserEmail')
                        ? post['UserEmail']
                        : '';
                    final timeStamp = post.data().containsKey('TimeStamp')
                        ? post['TimeStamp']
                        : '';
                    final likes =
                        post.data().containsKey('Likes') ? post['Likes'] : '';
                    final comments = post.data().containsKey('Comments')
                        ? post['Comments']
                        : '';
                    return WallPost(
                        message: message,
                        user: user,
                        time: timeStamp,
                        postId: post.id,
                        likes: List<String>.from(likes ?? []),
                        comments: List<dynamic>.from(comments ?? []));
                  });
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: $snapshot.error"),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }

  void signOut() {
    Navigator.pop(context);
    FirebaseAuth.instance.signOut();
  }

  void goToProfilePage() {
    Navigator.pop(context);
    Navigator.push(context,
        MaterialPageRoute(builder: ((context) => const ProfilePage())));
  }
}
