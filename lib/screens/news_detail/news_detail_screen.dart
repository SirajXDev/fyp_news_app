import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/screens/setting/setting_view.dart';
import 'package:news_application_2/utils/extensions/date_time_extension.dart';
import 'package:news_application_2/utils/utils.dart';

// ignore: must_be_immutable
class NewsDetailScreen extends StatefulWidget {
  String newsImage;
  String newsTitle;
  String newsDate;
  String newsAuthor;
  String newsDesc;
  String newsContent;
  String newsSource;
  NewsDetailScreen(this.newsImage, this.newsTitle, this.newsDate,
      this.newsAuthor, this.newsDesc, this.newsContent, this.newsSource,
      {super.key});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  final format = DateFormat('MMMM dd,yyyy');

  @override
  void initState() {
    super.initState();
    debugPrint(widget.newsDesc);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    DateTime dateTime = DateTime.parse(widget.newsDate);
    String timeAgo = dateTime.timeAgo();

    return Scaffold(
      appBar: AppBar(
        title: const TitleTextThemeWidget(title: 'News Detail View'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const CustomIconWidget(
            icon: Icons.arrow_back_ios,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(
              right: 10,
            ),
            child: Image(
              image: AssetImage('assets/images/share.png'),
              height: 22,
              color: AppColors.blackLight,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Stack(
          children: [
            SizedBox(
              height: height * 0.45,
              width: width,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: CachedNetworkImage(
                  imageUrl: widget.newsImage,
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
                      topRight: Radius.circular(30))),
              child: ListView(
                children: [
                  const TitleTextThemeWidget(title: "Title :"),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(widget.newsTitle,
                      style: GoogleFonts.poppins(
                          fontSize: 17,
                          color: AppColors.blackLight,
                          fontWeight: FontWeight.w700)),
                  SizedBox(height: height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 1),
                          decoration: BoxDecoration(
                            color: AppColors.greyLight,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            widget.newsSource,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      BodyTextThemeWidget(
                        title: timeAgo,
                        size: 12,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  const Divider(
                    thickness: .8,
                  ),
                  SizedBox(
                    height: height * 0.001,
                  ),
                  const TitleTextThemeWidget(title: "Description :"),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    widget.newsDesc,
                    style: GoogleFonts.poppins(
                        fontSize: 14.6,
                        color: AppColors.blackLight,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: height * 0.006,
                  ),
                  const Row(
                    children: [
                      Flexible(
                        child: CustomChip(),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const CustomIconWidget(
          icon: CupertinoIcons.bookmark,
          size: 22,
        ),
      ),
    );
  }
}

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    this.text,
    this.color,
    this.child,
  });

  final String? text;
  final Color? color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1.2),
      decoration: BoxDecoration(
        color: color ?? AppColors.orangeLight,
        borderRadius: BorderRadius.circular(4),
      ),
      child: child ?? BodyTextThemeWidget(title: text ?? "learn More.."),
    );
  }
}
