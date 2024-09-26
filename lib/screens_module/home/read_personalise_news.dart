import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/configs/components/custom_chip.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';
import 'package:news_application_2/configs/components/divider_horizontal_widget.dart';
import 'package:news_application_2/configs/routes/routes_name.dart';
import 'package:news_application_2/screens_module/admin/dashboard/home/admin-dashboard-parts/global-admin-widgets/text_form_fields_via_admin_cu.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';
import 'package:news_application_2/utils/helper_methods/navigation_utils.dart';
import 'package:news_application_2/utils/utils.dart';

class ReadPersonaliseNewsWidget extends StatelessWidget {
  const ReadPersonaliseNewsWidget({
    super.key,
    this.imageUrl,
    this.title,
    this.desc,
    this.author,
    this.source,
    this.timeAgo,
  });

  final String? imageUrl;
  final String? title;
  final String? desc;
  final String? author;
  final String? source;
  final String? timeAgo;


  static const exceptionalSources = {
    'gizmodo.com',
    'wired.com',
  };

  @override
  Widget build(BuildContext context) {
    if (_isExceptionalSource(imageUrl)) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        _buildImage(context),
        _buildArticleDetails(context),
      ],
    );
  }

  bool _isExceptionalSource(String? imageUrl) {
    return imageUrl != null &&
        exceptionalSources.contains(Uri.parse(imageUrl).host);
  }

  Widget _buildImage(BuildContext context) {
    if (imageUrl == null) return const SizedBox.shrink();

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        fit: BoxFit.cover,
        height: context.mqh * 0.14,
        width: context.mqw * 0.26,
        placeholder: (context, url) => const Center(
          child: SpinKitCircle(size: 50, color: Colors.blue),
        ),
        errorWidget: (context, url, error) => Image.asset(
          'assets/images/error-image.jpg',
          fit: BoxFit.cover,
          height: context.mqh * 0.18,
          width: context.mqw * 0.3,
        ),
      ),
    );
  }

  Widget _buildArticleDetails(BuildContext context) {
    return Expanded(
      child: Container(
        height: context.mqh * 0.18,
        padding: const EdgeInsets.only(left: 15),
        child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAuthorChip(context),
                _buildTitle(context),
                _buildSourceAndTimeAgo(context),
                const DividerHorizontalWidget(),
              ],
            ).paddingOnly(top: 10),

      ),
    );
  }


  Widget _buildAuthorChip(BuildContext context) {
    if (author == null) return const SizedBox.shrink();

    return Flexible(
      flex: 1,
      child: CustomChip(
        child: BodyTextThemeWidget(
          title:
          author!.length > 8 ? author!.substring(0, 8) : author ?? 'author',
          size: 12,
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Expanded(
      flex: 2,
      child: TitleTextThemeWidget(
        title: title ?? '',
        size: 16,
      ),
    );
  }

  Widget _buildSourceAndTimeAgo(BuildContext context) {
    return Row(
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
    );
  }
}
