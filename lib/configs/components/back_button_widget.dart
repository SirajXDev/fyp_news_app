import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    super.key,
    this.size,
    this.color,
    required this.isBackArrow,
  });

  final double? size;

  final Color? color;

  final bool isBackArrow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque, // Prevents unnecessary keyboard opening
      onTap: () {
        Navigator.pop(context);
        WidgetsBinding.instance.focusManager.primaryFocus
            ?.unfocus(); // Unfocus keyboard
      },
      child: CustomIconWidget(
        icon: isBackArrow ? CupertinoIcons.back : Icons.close,
        size: size ?? 16, // Provide default size if not provided
        color: color,
      ),
    );
  }
}
