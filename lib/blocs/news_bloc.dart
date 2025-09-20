import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/blocs/news_event.dart';
import 'package:news/blocs/news_state.dart';
import 'package:news/model/article.dart';
import 'package:news/services/supabase_service.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final SupabaseService service;

  NewsBloc({required this.service}) : super(const NewsState()) {
    on<LoadNews>(_onLoadNews);
  }

  Future<void> _onLoadNews(LoadNews event, Emitter<NewsState> emit) async {
    // Start loading for the target page
    final currentData = state.getPageData(event.page);
    emit(
      state.copyWith(
        pages: {
          ...state.pages,
          event.page: currentData.copyWith(status: NewsStatus.loading),
        },
      ),
    );

    try {
      List<Article> articles = [];
      Map<String, dynamic> result;

      if (event.page == NewsPage.home) {
        // Home articles
        result = await service.getHeadlines(country: 'us');
      } else if (event.page == NewsPage.search && event.query != null) {
        // Search results
        result = await service.searchNews(query: event.query);
      } else if (event.page == NewsPage.category && event.category != null) {
        // Category page
        result = await service.searchNews(category: event.category);
      } else {
        throw Exception("Invalid LoadNews event parameters");
      }

      final articlesJson = result['data']['articles'] as List<dynamic>? ?? [];
      articles = articlesJson.map((json) => Article.fromJson(json)).toList();

      emit(
        state.copyWith(
          pages: {
            ...state.pages,
            event.page: currentData.copyWith(
              articles: articles,
              status: NewsStatus.success,
            ),
          },
          categoryName: event.category ?? state.categoryName,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          pages: {
            ...state.pages,
            event.page: currentData.copyWith(
              status: NewsStatus.failure,
              error: e.toString(),
            ),
          },
        ),
      );
    }
  }
}
