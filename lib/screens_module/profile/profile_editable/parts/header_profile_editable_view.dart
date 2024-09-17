import 'package:flutter/cupertino.dart';
import 'package:news_application_2/configs/components/back_button_widget.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';

class HeaderProfileEdiatbleView extends StatelessWidget {
  const HeaderProfileEdiatbleView({super.key, this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const BackButtonWidget(
          isBackArrow: false,
          size: 20,
        ),
        const Spacer(),
        GestureDetector(
          onTap: onTap,
          child: const CustomIconWidget(
            icon: CupertinoIcons.check_mark,
            size: 20,
          ),
        ),
      ],
    );
  }
}
