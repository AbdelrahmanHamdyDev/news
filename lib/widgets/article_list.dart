import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:news/app_fonts.dart';
import '../blocs/news_bloc.dart';
import '../blocs/news_state.dart';
import '../widgets/article_card.dart';

class ArticleList extends StatelessWidget {
  final Future<void> Function()? onRefresh;
  final NewsPage type;

  const ArticleList({super.key, this.onRefresh, required this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          final pageData = state.getPageData(type);
          Widget coreWidget = ListView.separated(
            itemCount: pageData.articles.length,
            separatorBuilder: (context, index) => Divider(
              thickness: 1,
              height: 1.h,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            itemBuilder: (context, index) =>
                ArticleCard(article: pageData.articles[index]),
          );

          switch (pageData.status) {
            case NewsStatus.loading:
              return Center(
                child: Lottie.asset('assets/news_animation.json', repeat: true),
              );

            case NewsStatus.failure:
              return Center(
                child: Text(
                  'Error: ${pageData.error}',
                  style: AppFonts.bodyLarge.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              );

            case NewsStatus.success:
              if (pageData.articles.isEmpty) {
                return Center(
                  child: Text(
                    'No articles found.',
                    style: AppFonts.bodyLarge.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                );
              }
              return (onRefresh != null)
                  ? RefreshIndicator(onRefresh: onRefresh!, child: coreWidget)
                  : coreWidget;

            default:
              return Center(
                child: Text(
                  'No content available.',
                  style: AppFonts.bodyLarge.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
