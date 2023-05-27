import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar(
      {required this.title,
      super.key}); // title is an argument passed to the function

  final Widget title;

  @override
  Widget build(BuildContext context) {
    /*
    The Container widget lets you create a rectangular visual element. 
    A container can be decorated with a BoxDecoration, such as a background, a border, or a shadow. 
    A Container can also have margins, padding, and constraints applied to its size
    */

    /*
    The Expanded widget is used within a Row widget 
    to allocate any remaining space in the row to its child. 
    In this case, the Expanded widget wraps the title widget, 
    which occupies the available space in the row after the IconButton with the menu icon.
    Since the title widget is wrapped in an Expanded widget,
    the IconButton with the search icon is added as a child after the Expanded widget, 
    it will be positioned at the end of the row, 
    which is the right side in the default left-to-right layout of Flutter.

    An Expanded widget must be a descendant of a Row, Column, or Flex
    */

    return Container(
      height: 56.0, // in logical pixels
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.blue[500]),
      // Row is a horizontal, linear layout.
      child: Row(
        children: [
          const IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: null, // null disables the button
          ),
          Expanded(
            child: title,
          ),
          const IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {
  const MyScaffold({super.key});

  /*
    1. Theme.of(context) retrieves the current theme of the app from the provided context object. 
    The context is typically obtained from the BuildContext parameter passed to the build method of a widget.

    2. primaryTextTheme is a property of the theme that provides a set of text styles 
    specifically designed for primary text elements in the app. 
    It represents a collection of predefined text styles such as headings, titles, subtitles, etc.

    3. titleLarge is a specific text style within the primaryTextTheme that corresponds to a large-sized title text. 
    It is usually used for displaying important titles in the app.
  */

  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece
    // of paper on which the UI appears.
    return Material(
      // Column is a vertical, linear layout.
      child: Column(
        children: [
          MyAppBar(
            title: Text(
              'Example title',
              style: Theme.of(context) //
                  .primaryTextTheme
                  .titleLarge,
            ),
          ),
          const Expanded(
            child: Center(
              child: Text('Hello, world!'),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      title: 'My app', // used by the OS task switcher
      home: SafeArea(
        child: MyScaffold(),
      ),
    ),
  );
}
