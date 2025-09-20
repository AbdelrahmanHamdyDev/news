import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/app_fonts.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/blocs/news_event.dart';
import 'package:news/blocs/news_state.dart';
import 'package:news/views/category_page.dart';
import 'package:news/widgets/article_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {
  Future<void> _onRefresh() async {
    context.read<NewsBloc>().add(LoadNews(page: NewsPage.home));
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(LoadNews(page: NewsPage.home));
  }

  final List<String> categories = [
    "business",
    "entertainment",
    "health",
    "science",
    "sports",
    "technology",
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        SizedBox(
          height: 60.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Color(0xFF1565C0),
                    textStyle: AppFonts.bodyLarge.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CategoryPage(category: category),
                      ),
                    );
                  },
                  child: Text(
                    category[0].toUpperCase() + category.substring(1),
                  ),
                ),
              );
            },
          ),
        ),
        Divider(
          thickness: 1,
          height: 1,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        Expanded(
          child: ArticleList(
            onRefresh: () => _onRefresh(),
            type: NewsPage.home,
          ),
        ),
      ],
    );
  }
}
