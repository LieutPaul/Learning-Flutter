import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;
  const CustomTextBox(
      {super.key,
      required this.text,
      required this.sectionName,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.only(left: 15, bottom: 15),
        margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sectionName,
                  style: TextStyle(color: Colors.grey[500]),
                ),
                IconButton(
                  onPressed: onPressed,
                  icon: Icon(Icons.settings, color: Colors.grey[500]),
                )
              ],
            ),
            Text(text, style: const TextStyle(color: Colors.black))
          ],
        ));
  }
}
