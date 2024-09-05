import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_application_2/configs/color/color.dart';

import 'package:news_application_2/models/category_model.dart';
import 'package:news_application_2/screens/news_detail/news_detail_screen.dart';
import 'package:news_application_2/utils/extensions/date_time_extension.dart';
import 'package:news_application_2/utils/utils.dart';

class CategoryNewsDetailScreen extends StatefulWidget {
  final Articles article;

  const CategoryNewsDetailScreen({super.key, required this.article});

  @override
  State<CategoryNewsDetailScreen> createState() =>
      _CategoryNewsDetailScreenState();
}

class _CategoryNewsDetailScreenState extends State<CategoryNewsDetailScreen> {
  final format = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    DateTime dateTime =
        DateTime.parse(widget.article.publishedAt ?? DateTime.now().toString());
    String timeAgo = dateTime.timeAgo();

    return Scaffold(
      appBar: AppBar(
        title: const TitleTextThemeWidget(title: 'Article Detail View'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey[600],
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(
              right: 10,
            ),
            child: Image(
              image: AssetImage('assets/images/share.png'),
              height: 25,
              color: AppColors.blackLight,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: Stack(
          children: [
            SizedBox(
              height: height * 0.45,
              width: width,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.article.urlToImage ?? '',
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height * 0.4),
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
              height: height * 0.6,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: ListView(
                children: [
                  SizedBox(height: height * 0.01),
                  const TitleTextThemeWidget(title: 'Title :'),
                  SizedBox(height: height * 0.01),
                  Text(
                    widget.article.title ?? 'No title',
                    style: GoogleFonts.poppins(
                      fontSize: 17.1,
                      color: AppColors.blackLight,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: CustomChip(
                          color: AppColors.greyLight,
                          child: Text(
                            widget.article.source?.name ?? 'Unknown source',
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        timeAgo,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  // Text(
                  //   widget.article.description ?? 'No description',
                  //   style: GoogleFonts.poppins(
                  //     fontSize: 15,
                  //     color: Colors.black87,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                  const Divider(),
                  SizedBox(height: height * 0.01),
                  const TitleTextThemeWidget(title: 'Description :'),
                  SizedBox(height: height * 0.01),

                  Text(
                    widget.article.content ?? 'No content',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: height * 0.03),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.bookmark_outline,
          size: 30,
          color: AppColors.blackLight,
        ),
      ),
    );
  }
}
