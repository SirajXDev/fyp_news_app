import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mews_application_2/models/news_channel_headline.dart';
import 'package:mews_application_2/screens/category_screen.dart';
import 'package:mews_application_2/screens/news_detail_screen.dart';
import 'package:mews_application_2/view_model/news_list.dart';
import 'package:mews_application_2/view_model/news_view_model.dart';


class HomeScreen extends StatefulWidget {
  
const   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList { bbcNews, aryNews, independent, cnn, aljazeera }

class _HomeScreenState extends State<HomeScreen> {
  final format = DateFormat('MMMM dd, yyyy');

  String name = 'bbc-news';
  NewsViewModel newsViewModel = NewsViewModel();

  FilterList? selectedMenu;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CategoriesScreen()));
          },
          icon: Image.asset(
            'images/category_icon.png',
            height: 30,
            width: 30,
          ),
        ),
        title: Text(
          'News',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<FilterList>(
            initialValue: selectedMenu,
            icon: const Icon(Icons.more_vert_outlined),
            onSelected: (FilterList item) {
              setState(() {
                selectedMenu = item;
                if (item == FilterList.bbcNews) {
                  name = 'bbc-news';
                }
                if (item == FilterList.aryNews) {
                  name = 'ary-news';
                }
                if (item == FilterList.aljazeera) {
                  name = 'al-jazeera-english';
                }
              });
            },
            itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
              const PopupMenuItem<FilterList>(
                value: FilterList.bbcNews,
                child: Text('BBC News'),
              ),
              const PopupMenuItem<FilterList>(
                value: FilterList.aryNews,
                child: Text('Ary News'),
              ),
              const PopupMenuItem<FilterList>(
                value: FilterList.aljazeera,
                child: Text('Al Jazeera English'),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsChannelHeadlineModel>(
              future: newsViewModel.fetchNewsChannelHeadlineApi(name),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitCircle(
                      color: Colors.blue,
                      size: 50,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData ||
                    snapshot.data!.articles!.isEmpty) {
                  return const Center(
                    child: Text('No data available'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(
                        snapshot.data!.articles![index].publishedAt.toString(),
                      );
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewsDetailScreen(
                                    
                                        snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        snapshot.data!.articles![index].title
                                            .toString(),
                                        snapshot
                                            .data!.articles![index].publishedAt
                                            .toString(),
                                        snapshot.data!.articles![index].author
                                            .toString(),
                                        snapshot
                                            .data!.articles![index].description
                                            .toString(),
                                        snapshot.data!.articles![index].content
                                            .toString(),
                                        snapshot
                                            .data!.articles![index].source!.name
                                            .toString(),
                                      ),
                                      ));
                        },
                        child: SizedBox(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: height * 0.6,
                                width: width * .9,
                                padding: EdgeInsets.symmetric(
                                    horizontal: height * .02),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        Container(child: spinKit2),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(15),
                                    height: height * .22,
                                    alignment: Alignment.bottomCenter,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: width * 0.7,
                                          child: Text(
                                            snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        SizedBox(
                                          width: width * 0.7,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  snapshot
                                                      .data!
                                                      .articles![index]
                                                      .source!
                                                      .name
                                                      .toString(),
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 13,
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                format.format(dateTime),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          
          //here the list which show down the headline section
          const SizedBox(
            height: 300,
            child: NewslistScreen()),
         
        ],
      ),
    );
  }
}

const spinKit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
