import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Function()? onTap;
  final IconData icon;
  final String text;
  const CustomListTile(
      {super.key, required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: ListTile(
          onTap: onTap,
          leading: Icon(icon, color: Colors.white),
          title: Text(text, style: const TextStyle(color: Colors.white))),
    );
  }
}
