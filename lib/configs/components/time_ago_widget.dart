import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/configs/components/custom_chip.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';

class TimeAgoWidget extends StatelessWidget {
  const TimeAgoWidget({
    super.key,
    required this.timeAgo,
    this.iconColor,
    this.iconSize,
    this.chipColor,
  });
  final String timeAgo;
  final Color? iconColor;
  final double? iconSize;
  final Color? chipColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          CupertinoIcons.time,
          size: iconSize ?? 18,
          color: iconColor ?? AppColors.redLight,
        ),
        4.w,
        CustomChip(
          color: chipColor ?? AppColors.whiteLight,
          child: Text(
            timeAgo,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
