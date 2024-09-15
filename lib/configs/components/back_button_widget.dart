import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget(
      {super.key, this.size, this.color, required this.isBackArrow});
  final double? size;
  final Color? color;
  final bool isBackArrow;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: CustomIconWidget(
          icon: isBackArrow ? CupertinoIcons.back : Icons.close,
          size: 16,
          color: color,
        ));
  }
}
