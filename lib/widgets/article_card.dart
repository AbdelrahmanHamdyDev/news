import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news/app_fonts.dart';
import 'package:news/model/article.dart';
import 'package:news/views/article_detail_page.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({super.key, required this.article});

  String formatTimeAgo(DateTime publishedAt) {
    final diff = DateTime.now().difference(publishedAt);
    if (diff.inDays > 0) return "${diff.inDays}d ago";
    if (diff.inHours > 0) return "${diff.inHours}h ago";
    if (diff.inMinutes > 0) return "${diff.inMinutes}m ago";
    return "Just now";
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime_publishedAt = DateTime.parse(article.publishedAt);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ArticleDetailPage(
                article: article,
                parse_time: dateTime_publishedAt,
              ),
            ),
          );
        },
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.network(
                  article.imageUrl,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                child: Column(
                  spacing: 10.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.headlineMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      article.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppFonts.bodyMedium.copyWith(
                        fontSize: 12.sp,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          article.sourceName.replaceAll('-', ' '),
                          style: AppFonts.headlineMedium.copyWith(
                            color: Colors.grey[600],
                            fontSize: 10.sp,
                          ),
                        ),
                        Row(
                          spacing: 3.w,
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 10.sp,
                              color: Colors.grey[600],
                            ),
                            Text(
                              formatTimeAgo(dateTime_publishedAt),
                              style: AppFonts.headlineMedium.copyWith(
                                color: Colors.grey[600],
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
