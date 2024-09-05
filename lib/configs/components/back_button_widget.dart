import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key, this.size, this.color});
  final double? size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(
          CupertinoIcons.back,
          color: color ?? Theme.of(context).colorScheme.primary,
          size: size ?? 16,
        ));
  }
}
