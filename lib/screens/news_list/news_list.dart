// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:news_application_2/configs/color/color.dart';
// import 'package:news_application_2/models/category_model.dart';
// import 'package:news_application_2/repositiry%20copy/category_repo.dart';
// import 'package:news_application_2/screens/categ_detail/cartegrydetail_screen.dart';
// import 'package:news_application_2/screens/news_detail/news_detail_screen.dart';
// import 'package:news_application_2/utils/extensions/date_time_extension.dart';
// import 'package:news_application_2/utils/extensions/general_extension.dart';
// import 'package:news_application_2/utils/utils.dart';

// class NewslistScreen extends StatefulWidget {
//   const NewslistScreen({super.key});

//   @override
//   State<NewslistScreen> createState() => _NewslistScreenState();
// }

// class _NewslistScreenState extends State<NewslistScreen> {
//   final format = DateFormat('MMM dd, yyyy');
//   final NewsCategoriesRepo newsRepo = NewsCategoriesRepo();
//   CategoriesNewsMdl? newsData;

//   @override
//   void initState() {
//     super.initState();
//     fetchNewsData('General'); // Fetch initial data for the 'General' category
//   }

//   Future<void> fetchNewsData(String category) async {
//     try {
//       final data = await newsRepo.fetchNewsCategoires(category);
//       setState(() {
//         newsData = data;
//       });
//     } catch (e) {
//       // Handle error
//       debugPrint('Error fetching news: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.sizeOf(context).width;
//     final height = MediaQuery.sizeOf(context).height;

//     return Scaffold(
//       body: newsData == null
//           ? const Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: newsData!.articles?.length ?? 0,
//               itemBuilder: (context, index) {
//                 final article = newsData!.articles![index];
//                 var timeAgo = DateTime.parse(article.publishedAt!).timeAgo();

//                 return article.urlToImage != null
//                     ? Padding(
//                         padding: const EdgeInsets.only(bottom: 0),
//                         child: InkWell(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => CategoryNewsDetailScreen(
//                                   article: article,
//                                 ),
//                               ),
//                             );
//                           },
//                           child: Row(
//                             children: [
//                               article.urlToImage != null
//                                   ? ClipRRect(
//                                       borderRadius: BorderRadius.circular(15),
//                                       child: CachedNetworkImage(
//                                         imageUrl: article.urlToImage ?? '',
//                                         fit: BoxFit.cover,
//                                         height: height * .18,
//                                         width: width * .3,
//                                         placeholder: (context, url) =>
//                                             const Center(
//                                           child: SpinKitCircle(
//                                               size: 50, color: Colors.blue),
//                                         ),
//                                         errorWidget: (context, url, error) =>
//                                             const Icon(
//                                           Icons.error_outline,
//                                           color: Colors.red,
//                                         ),
//                                       ),
//                                     )
//                                   : const SizedBox.shrink(),
//                               Expanded(
//                                 child: Container(
//                                   // color: AppColors.greyLight,
//                                   height: height * .18,
//                                   padding: const EdgeInsets.only(left: 15),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       CustomChip(
//                                         color: AppColors.greenLight,
//                                         child: Text(
//                                           article.author ?? '',
//                                           maxLines: 3,
//                                           style: Utils.titleTextTheme(
//                                             context: context,
//                                             size: 14,
//                                           ),
//                                         ),
//                                       ),
//                                       10.h,
//                                       Text(
//                                         article.title ?? '',
//                                         maxLines: 3,
//                                         style: Utils.titleTextTheme(
//                                           context: context,
//                                           size: 14,
//                                         ),
//                                       ),
//                                       const Spacer(),
//                                       const CustomHorizontalDivider(),
//                                       2.h,
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Flexible(
//                                             child: CustomChip(
//                                               child: Text(
//                                                 article.source?.name ?? '',
//                                                 style: Utils.bodyTextTheme(
//                                                   context: context,
//                                                   size: 12.5,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           CustomChip(
//                                             child: Text(
//                                               timeAgo,
//                                               style: Utils.bodyTextTheme(
//                                                 context: context,
//                                                 size: 12.5,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     : const SizedBox.shrink();
//               },
//             ),
//     );
//   }
// }

// class CustomHorizontalDivider extends StatelessWidget {
//   const CustomHorizontalDivider({
//     super.key,
//     this.indent,
//     this.endIndent,
//     this.thickness,
//     this.color,
//   });
//   final double? indent;
//   final double? endIndent;
//   final double? thickness;
//   final Color? color;

//   @override
//   Widget build(BuildContext context) {
//     return Divider(
//       thickness: thickness ?? .8,
//       indent: indent,
//       endIndent: endIndent,
//       color: color,
//     );
//   }
// }
