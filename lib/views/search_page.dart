import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/blocs/news_bloc.dart';
import 'package:news/blocs/news_event.dart';
import 'package:news/blocs/news_state.dart';
import 'package:news/widgets/article_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _onSubmit(String enteredText) {
    if (enteredText.isNotEmpty) {
      context.read<NewsBloc>().add(
        LoadNews(query: enteredText, page: NewsPage.search),
      );
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Enter text to search!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: SearchBar(
            controller: _controller,
            hintText: "Type a keyword to explore news...",
            leading: Icon(Icons.search),
            onSubmitted: (value) => _onSubmit(value),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: ArticleList(type: NewsPage.search),
          ),
        ),
      ],
    );
  }
}
