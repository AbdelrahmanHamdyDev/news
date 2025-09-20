import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/app_fonts.dart';
import 'package:news/model/article.dart';
import 'package:news/widgets/standalone_AppBar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class ArticleDetailPage extends StatelessWidget {
  final Article article;
  final DateTime parse_time;

  const ArticleDetailPage({
    super.key,
    required this.article,
    required this.parse_time,
  });

  Future<void> _openLink() async {
    final Uri url = Uri.parse(article.url);
    if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat("dd MMM yyyy, hh:mm a").format(parse_time);
    return Scaffold(
      floatingActionButton: IconButton(
        onPressed: _openLink,
        icon: Icon(Icons.public, color: Colors.white, size: 30.sp),
        style: IconButton.styleFrom(backgroundColor: Color(0xFF1565C0)),
      ),
      appBar: StandaloneAppBar(
        titleWidget: Text(
          article.sourceName.replaceAll('-', ' '),
          style: AppFonts.headlineLarge.copyWith(
            fontSize: 18.sp,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          spacing: 20.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title.contains('-')
                  ? article.title
                        .substring(0, article.title.lastIndexOf('-'))
                        .trim()
                  : article.title,

              style: AppFonts.headlineLarge.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                article.imageUrl,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image),
              ),
            ),
            Text(
              article.description,
              style: AppFonts.bodyMedium.copyWith(
                fontSize: 16.sp,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Row(
              children: [
                Text(
                  'Published at: ',
                  style: AppFonts.headlineMedium.copyWith(
                    fontSize: 14.sp,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  formattedDate,
                  style: AppFonts.bodyMedium.copyWith(color: Colors.grey[700]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
