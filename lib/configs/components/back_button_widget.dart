import 'package:flutter/cupertino.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key, this.size, this.color});
  final double? size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const CustomIconWidget(
          icon: CupertinoIcons.back,
          size: 16,
        ));
  }
}
