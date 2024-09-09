import 'package:flutter/material.dart';

class BookMarkView extends StatelessWidget {
  const BookMarkView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('BookMark'),
        centerTitle: true,
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
