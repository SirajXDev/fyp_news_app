import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_application_2/configs/color/color.dart';
import 'package:news_application_2/configs/components/custom_icon_widget.dart';
import 'package:news_application_2/configs/components/divider_horizontal_widget.dart';
import 'package:news_application_2/configs/components/heading_text_widget.dart';
import 'package:news_application_2/utils/enums.dart';
import 'package:news_application_2/utils/extensions/general_extension.dart';
import 'package:news_application_2/utils/extensions/widget_extension.dart';
import 'package:news_application_2/utils/utils.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: context.mqh * .03,
                ),
                // page titlle
                HeadingTextWidget(
                  headingText: 'Search',
                  color: Theme.of(context).colorScheme.primary,
                ),
                SizedBox(
                  height: context.mqh * .02,
                ),
                // searh field
                const SearchNewsTextField(),
                // sortBy
                // const SortBySearch(),
                SizedBox(
                  height: context.mqh * .02,
                ),
                const DividerHorizontalWidget(
                  weight: .1,
                  endIndent: 25,
                ),
                SizedBox(
                  height: context.mqh * .01,
                ),
                // render searched data
                const RenderSearchedData(),
              ],
            ).paddingSymmetric(horizontal: 15),
          ),
        ),
      ),
    );
  }
}

class SearchNewsTextField extends StatefulWidget {
  const SearchNewsTextField({
    super.key,
  });

  @override
  State<SearchNewsTextField> createState() => _SearchNewsTextFieldState();
}

class _SearchNewsTextFieldState extends State<SearchNewsTextField> {
  final TextEditingController _searchTextController = TextEditingController();
  String? _selectedFilter;

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: TextField(
            controller: _searchTextController,
            decoration: InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(
                CupertinoIcons.search,
                color: Theme.of(context).colorScheme.secondary,
              ),
              labelStyle: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              suffixIcon: PopupMenuButton(
                icon: CustomIconWidget(
                  icon: Icons.sort,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                color: Theme.of(context).colorScheme.outline,
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: SearchFilter.publishedAt,
                    child: TitleTextThemeWidget(
                      title: 'Published At',
                      size: 12,
                    ),
                  ),
                  const PopupMenuItem(
                    value: SearchFilter.relevancy,
                    child: TitleTextThemeWidget(
                      title: 'Relevancy',
                      size: 12,
                    ),
                  ),
                  const PopupMenuItem(
                    value: SearchFilter.popularity,
                    child: TitleTextThemeWidget(
                      title: 'popularity',
                      size: 12,
                    ),
                  ),
                ],
                onSelected: (value) {
                  setState(() {
                    _selectedFilter = value.name;
                  });
                  // Handle the selected item
                  if (kDebugMode) {
                    print('Selected: $value');
                  }
                },
              ),
            ),
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ),
        SizedBox(
          width: context.mqw * .02,
        ),
        Image(
          image: const AssetImage(
            'assets/images/search.png',
          ),
          height: context.mqh * .04,
          color: Theme.of(context).colorScheme.secondary,
        )
      ],
    );
  }
}
// class SortBySearch extends StatelessWidget {
//   const SortBySearch({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const BodyTextThemeWidget(
//           title: "SortBy",
//           size: 12,
//         ),
//         PopupMenuButton(
//           icon: CustomIconWidget(
//             icon: Icons.sort,
//             color: Theme.of(context).colorScheme.onPrimary,
//           ),
//           color: Theme.of(context).colorScheme.outline,
//           itemBuilder: (context) => [
//             const PopupMenuItem(
//               value: SearchFilter.publishedAt,
//               child: TitleTextThemeWidget(
//                 title: 'Published At',
//                 size: 12,
//               ),
//             ),
//             const PopupMenuItem(
//               value: SearchFilter.relevancy,
//               child: TitleTextThemeWidget(
//                 title: 'Relevancy',
//                 size: 12,
//               ),
//             ),
//             const PopupMenuItem(
//               value: SearchFilter.popularity,
//               child: TitleTextThemeWidget(
//                 title: 'popularity',
//                 size: 12,
//               ),
//             ),
//           ],
//           onSelected: (value) {
//             // Handle the selected item
//             if (kDebugMode) {
//               print('Selected: $value');
//             }
//           },
//         ),
//       ],
//     ).paddingOnly(right: context.mqw * .06);
//   }
// }

class RenderSearchedData extends StatelessWidget {
  const RenderSearchedData({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            TitleTextThemeWidget(
              title: 'Shows Data For ',
              color: AppColors.grey,
            ),
            TitleTextThemeWidget(
              title: 'Imran Khan',
            )
          ],
        ),
      ],
    );
  }
}
