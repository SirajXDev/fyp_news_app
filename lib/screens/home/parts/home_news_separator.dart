import 'package:flutter/material.dart';

class HomeNewsSeparator extends StatelessWidget {
  const HomeNewsSeparator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        thickness: .33,
      ),
    );
  }
}
