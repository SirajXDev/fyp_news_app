import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_application_2/models/category_model.dart';
import 'package:news_application_2/repositiry%20copy/category_repo.dart';
import 'package:news_application_2/screens/cartegrydetail_screen.dart';

class NewslistScreen extends StatefulWidget {
  const NewslistScreen({super.key});

  @override
  State<NewslistScreen> createState() => _NewslistScreenState();
}

class _NewslistScreenState extends State<NewslistScreen> {
  final format = DateFormat('MMM dd, yyyy');
  final NewsCategoriesRepo newsRepo = NewsCategoriesRepo();
  CategoriesNewsModel? newsData;

  @override
  void initState() {
    super.initState();
    fetchNewsData('General'); // Fetch initial data for the 'General' category
  }

  Future<void> fetchNewsData(String category) async {
    try {
      final data = await newsRepo.fetchNewsCategoires(category);
      setState(() {
        newsData = data;
      });
    } catch (e) {
      // Handle error
      print('Error fetching news: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: newsData == null
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: newsData!.articles?.length ?? 0,
                itemBuilder: (context, index) {
                  final article = newsData!.articles![index];
                  DateTime dateTime = DateTime.parse(article.publishedAt!);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryNewsDetailScreen(
                              article: article,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl: article.urlToImage ?? '',
                              fit: BoxFit.cover,
                              height: height * .18,
                              width: width * .3,
                              placeholder: (context, url) => const Center(
                                child:
                                    SpinKitCircle(size: 50, color: Colors.blue),
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error_outline,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: height * .18,
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                children: [
                                  Text(
                                    article.title ?? '',
                                    maxLines: 3,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          article.source?.name ?? '',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        format.format(dateTime),
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
