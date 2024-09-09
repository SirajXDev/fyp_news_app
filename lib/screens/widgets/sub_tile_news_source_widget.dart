import 'package:flutter/cupertino.dart';
import 'package:news_application_2/configs/components/custom_chip.dart';
import 'package:news_application_2/screens/news_detail/news_detail_screen.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/utils.dart';

class SubTilesNewsSourceWidget extends StatelessWidget {
  const SubTilesNewsSourceWidget({
    super.key,
    this.timeAgo,
    this.source,
    this.author,
  });

  final String? source;
  final String? author;
  final String? timeAgo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          // or Flexible
          child: Row(
            children: [
              Flexible(
                child: CustomChip(
                  child: BodyTextThemeWidget(
                    title: source ?? 'source',
                    size: 12,
                  ),
                ),
              ),
              15.w,
              Flexible(
                child: CustomChip(
                  child: BodyTextThemeWidget(
                    title: author!.length > 8
                        ? author!.substring(0, 8)
                        : author ?? 'author',
                    size: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        BodyTextThemeWidget(
          title: timeAgo ?? '12h',
          size: 12,
        ),
      ],
    );
  }
}
