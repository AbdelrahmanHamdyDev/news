import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/app_fonts.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/blocs/news_event.dart';
import 'package:news/blocs/news_state.dart';
import 'package:news/widgets/article_list.dart';
import 'package:news/widgets/standalone_AppBar.dart';

class CategoryPage extends StatefulWidget {
  final String category;

  const CategoryPage({super.key, required this.category});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<NewsBloc>().add(
      LoadNews(category: widget.category, page: NewsPage.category),
    );
  }

  Future<void> _onRefresh() async {
    context.read<NewsBloc>().add(
      LoadNews(category: widget.category, page: NewsPage.category),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandaloneAppBar(
        titleWidget: Text(
          widget.category[0].toUpperCase() + widget.category.substring(1),
          style: AppFonts.headlineLarge.copyWith(
            fontSize: 18.sp,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      body: ArticleList(onRefresh: () => _onRefresh(), type: NewsPage.category),
    );
  }
}
