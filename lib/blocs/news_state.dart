import 'package:news/model/article.dart';

enum NewsStatus { initial, loading, success, failure }

enum NewsPage { home, search, category }

class PageData {
  final List<Article> articles;
  final NewsStatus status;
  final String? error;

  const PageData({
    this.articles = const [],
    this.status = NewsStatus.initial,
    this.error,
  });

  PageData copyWith({
    List<Article>? articles,
    NewsStatus? status,
    String? error,
  }) {
    return PageData(
      articles: articles ?? this.articles,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}

class NewsState {
  final Map<NewsPage, PageData> pages;
  final String? categoryName; // for dynamic category page

  const NewsState({this.pages = const {}, this.categoryName});

  NewsState copyWith({Map<NewsPage, PageData>? pages, String? categoryName}) {
    return NewsState(
      pages: pages ?? this.pages,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  PageData getPageData(NewsPage page) {
    return pages[page] ?? const PageData();
  }
}
