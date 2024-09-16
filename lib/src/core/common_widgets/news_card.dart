import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/src/core/theme/app_colors.dart';
import 'package:news_app/src/core/utils/datetime.dart';
import 'package:news_app/src/domain/entity/news.dart';
import 'package:news_app/src/presentation/news_list/providers/save_news_provider.dart';

class NewsCard extends ConsumerWidget {
  const NewsCard({
    super.key,
    required this.news,
    this.hideTopLine = false,
    this.hideBottomLine = false,
    this.isSaved = false,
  });
  final News news;
  final bool hideTopLine;
  final bool hideBottomLine;
  final bool isSaved;

  final hPadding = const EdgeInsets.symmetric(horizontal: 10.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final dividerColor = Theme.of(context).dividerColor;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      // alignment: Alignment.center,
      children: [
        _VerticalLine(
          hide: hideTopLine,
          dividerColor: dividerColor,
        ),
        const Divider(
          thickness: 1,
          height: 0,
          endIndent: 0,
          indent: 0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 16),
          color: AppColors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      news.title,
                      style: textTheme.headlineSmall,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      ref.read(saveNewsProvider.call(news));
                    },
                    child: Icon(
                      Icons.bookmark,
                      size: 30,
                      color: isSaved ? AppColors.primary : AppColors.lightGray,
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 3),
              const SizedBox(height: 8),
              Text(
                news.timestamp.dateTimeFullFormat,
                style: textTheme.bodySmall,
                textAlign: TextAlign.end,
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 220,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: news.images!.thumbnail,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.lightGray,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                news.snippet,
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          height: 0,
          endIndent: 0,
          indent: 0,
        ),
        _VerticalLine(
          hide: hideBottomLine,
          dividerColor: dividerColor,
        ),
      ],
    );
  }
}

class _VerticalLine extends StatelessWidget {
  const _VerticalLine({
    required this.hide,
    required this.dividerColor,
  });

  final bool hide;
  final Color dividerColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: VerticalDivider(
            color: hide ? Colors.transparent : dividerColor,
            thickness: 1,
            width: 0,
            endIndent: 0,
            indent: 0,
          ),
        ),
      ),
    );
  }
}
