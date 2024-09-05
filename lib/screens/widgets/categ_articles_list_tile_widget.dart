import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/configs/components/custom_chip.dart';
import 'package:news_application_2/configs/components/divider_horizontal_widget.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/utils.dart';

class CategArticlesListTilesWidget extends StatelessWidget {
  CategArticlesListTilesWidget({
    super.key,
    required this.timeAgo,
    this.imageUrl,
    this.author,
    this.title,
    this.source,
  });

  final String? imageUrl;
  final String? author;
  final String? title;
  final String? source;
  final String? timeAgo;

  final exceptionalSources = {
    'gizmodo.com',
    'wired.com',
  };
  @override
  Widget build(BuildContext context) {
    if (imageUrl != null &&
        exceptionalSources.contains(Uri.parse(imageUrl!).host)) {
      return const SizedBox.shrink();
    } else {
      return Row(
        children: [
          imageUrl != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl ?? '', // Use the actual image URL
                    fit: BoxFit.cover,
                    height: context.mqh * .18,
                    width: context.mqw * .3,
                    placeholder: (context, url) => const Center(
                      child: SpinKitCircle(size: 50, color: Colors.blue),
                    ),
                    errorWidget: (context, url, error) =>
                        Image.asset('assets/images/error-image.jpg'),
                  ),
                )
              : const SizedBox.shrink(),
          Expanded(
            child: Container(
              height: context.mqh * .18,
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  author != null
                      ? CustomChip(
                          child: BodyTextThemeWidget(
                            title: author ?? '',
                            size: 12,
                          ),
                        )
                      : const SizedBox.shrink(),
                  author != null
                      ? const SizedBox(
                          height: 10,
                        )
                      : const SizedBox(
                          height: 30,
                        ),
                  TitleTextThemeWidget(
                    title: title ?? '',
                    size: 16,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: CustomChip(
                          color: AppColors.greenLight,
                          child: BodyTextThemeWidget(
                            title: source ?? '',
                            size: 12,
                          ),
                        ),
                      ),
                      Flexible(
                        child: BodyTextThemeWidget(
                          title: timeAgo ?? '10h',
                          size: 12,
                        ),
                      ),
                    ],
                  ),
                  const DividerHorizontalWidget(),
                ],
              ),
            ),
          ),
        ],
      );
    }
  }
}
