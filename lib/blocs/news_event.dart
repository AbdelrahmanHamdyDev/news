import 'package:news/blocs/news_state.dart';

abstract class NewsEvent {
  const NewsEvent();
}

class LoadNews extends NewsEvent {
  final String? query; // search query
  final String? category; // category for category page
  final NewsPage page;

  const LoadNews({this.query, this.category, required this.page});
}
