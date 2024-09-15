import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';
import 'loading_widget.dart';

//custom network image widget, we will used this widget show images, also handled exceptions
// this widget is generic, we can change it and this change will appear across the app
class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double width, height, borderRadius, iconSize;
  final BoxFit boxFit;
  const NetworkImageWidget(
      {super.key,
      required this.imageUrl,
      this.width = 40,
      this.height = 40,
      this.borderRadius = 0,
      this.iconSize = 20,
      this.boxFit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return imageUrl == ''
        ? Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outline,
                // borderRadius: BorderRadius.circular(borderRadius),
                shape: BoxShape.circle),
            child: CustomIconWidget(
              icon: Icons.person_outline,
              size: iconSize,
            ),
          )
        : CachedNetworkImage(
            imageUrl: imageUrl,
            width: width,
            height: height,
            imageBuilder: (context, imageProvider) => Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(borderRadius),
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: boxFit,
                ),
              ),
            ),
            placeholder: (context, url) => Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outline,
                  // borderRadius: BorderRadius.circular(borderRadius),
                  shape: BoxShape.circle),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: LoadingWidget(),
              ),
            ),
            errorWidget: (context, url, error) => Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(
                    color: AppColors.redLight,
                    // borderRadius: BorderRadius.circular(13),
                    shape: BoxShape.circle),
                child: CustomIconWidget(
                  size: iconSize,
                  icon: Icons.error_outline,
                )),
          );
  }
}
