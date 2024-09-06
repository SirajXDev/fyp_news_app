import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/configs/components/custom_chip.dart';
import 'package:news_application_2/configs/components/time_ago_widget.dart';
import 'package:news_application_2/models/channels_headlines/channels_news_headlines.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/utils.dart';

class HeadLinesNewsCardWidget extends StatelessWidget {
  const HeadLinesNewsCardWidget(
      {super.key, required this.headlines, required this.timeAgo});
  final Articles headlines;

  final String timeAgo;
  @override
  Widget build(BuildContext context) {
    return Stack(
      // alignment: Alignment.center,
      children: [
        Container(
          height: context.mqh * 0.24, // Set a fixed height
          width: context.mqw * .95,
          padding: EdgeInsets.only(
              right: context.mqw * .001, left: context.mqw * .026, top: 0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              // height: height * 0.9,
              imageUrl: headlines.urlToImage.toString(),
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(child: Utils.spinKit2),
              errorWidget: (context, url, error) => const Icon(
                Icons.error_outline,
                color: Colors.red,
              ),
            ),
          ),
        ),
        Positioned(
          top: context.mqh * .16,
          left: context.mqw * .08,
          // bottom: 4,
          child: Card(
            color: Theme.of(context).cardColor,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              padding: EdgeInsets.only(
                top: context.mqh * .01,
                bottom: context.mqh * .006,
                left: context.mqw * .02,
                right: context.mqw * .02,
              ),
              height: context.mqh * .13,
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: context.mqw * 0.7,
                    child: Text(
                      headlines.title.toString(),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 12.6,
                        color: AppColors.blackLight,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: context.mqw * 0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: CustomChip(
                            color: AppColors.whiteLight,
                            child: Text(
                              headlines.source!.name.toString(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        TimeAgoWidget(
                          timeAgo: timeAgo,
                          iconColor: AppColors.blackLight,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
