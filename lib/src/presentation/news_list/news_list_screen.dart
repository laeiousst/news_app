import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/src/core/common_widgets/news_card.dart';
import 'package:news_app/src/core/exceptions/exceptions.dart';
import 'package:news_app/src/core/theme/app_colors.dart';
import 'package:news_app/src/presentation/news_list/providers/news_list_provider.dart';
import 'package:news_app/src/presentation/news_list/widgets/scroll_button.dart';
import 'package:news_app/src/presentation/news_list/widgets/topic_selector.dart';
import 'package:news_app/src/presentation/saved_news/providers/saved_news_list_provider.dart';

class NewsListScreen extends ConsumerStatefulWidget {
  const NewsListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends ConsumerState<NewsListScreen> {
  final _pageController = PageController();
  final _transitionDuration = const Duration(milliseconds: 300);
  final _transitionCurve = Curves.easeInOut;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newsList = ref.watch(newsListProvider);
    final savedList = ref.watch(savedNewsListProvider);

    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: TopicSelector(),
          ),
          Expanded(
            child: switch (newsList) {
              AsyncData(:final value) => PageView.builder(
                  controller: _pageController,
                  itemCount: value.length,
                  scrollDirection: Axis.vertical,
                  allowImplicitScrolling: true,
                  itemBuilder: (context, index) {
                    final isSaved = savedList.hasValue
                        ? savedList.asData!.value.any(
                            (e) => e.timestamp == value[index].timestamp,
                          )
                        : false;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (index > 0)
                          ScrollButton(
                            title: "Previous",
                            icon: Icons.keyboard_double_arrow_up_rounded,
                            onPressed: () {
                              _pageController.previousPage(
                                duration: _transitionDuration,
                                curve: _transitionCurve,
                              );
                            },
                          ),
                        Expanded(
                          child: NewsCard(
                            key: Key('${value[index].timestamp}_$isSaved'),
                            news: value[index],
                            hideTopLine: index == 0,
                            hideBottomLine: index == 2,
                            isSaved: isSaved,
                          ),
                        ),
                        if (index < value.length - 1)
                          ScrollButton(
                            title: "Next",
                            icon: Icons.keyboard_double_arrow_down_rounded,
                            onPressed: () {
                              _pageController.nextPage(
                                duration: _transitionDuration,
                                curve: _transitionCurve,
                              );
                            },
                          ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }),
              AsyncError(:final error) => Center(
                  child: Text(
                    error is LimitReachedException
                        ? 'Too many requests! You\'ve hit the limit for now.\nPlease wait before trying again.'
                        : 'Oops, something unexpected happened',
                    textAlign: TextAlign.center,
                  ),
                ),
              _ => Center(
                  child: LoadingAnimationWidget.stretchedDots(
                    color: AppColors.darkGray,
                    size: 50,
                  ),
                ),
            },
          ),
        ],
      ),
    );
  }
}
